# Home Lab: Ansible

Ansible playbooks and roles to deploy Home Lab environment, install packages and perform updates.

## K8s

Kubernetes lab with 1 control plane and 2 worker nodes

This is a K8s setup I am using to test on my dev environment on a separate box (Proxmox VMs).

The whole setup consists of 1 control plane node (2 vCPUs, 4 GB RAM, 30 GB disk) and 2 worker nodes (2 vCPUs, 2 GB RAM, 30 GB disk).

### My Environment specifics

You might want to adapt this to your environment.

* Local hosts are on 192.168.68.0/24 subnet
* All 3 hosts running latest Ubuntu 20.04 LTS (to be upgraded to 22.04 LTS at some point)
* Local user: robertas
* `~/.ssh/config` file has the following:
```
Host k8s0
        HostName 192.168.68.16
        User robertas

Host k8s1
        HostName 192.168.68.17
        User robertas

Host k8s2
        HostName 192.168.68.18
        User robertas
```
* I ran `ssh-copy-id robertas@k8s0` (and the worker nodes) - for ease of access to hosts
* I also update sudoers file with `sudo visudo` on each host with below so I don't need password on every sudo. **! ! ! DEVELOPMENT ONLY ! ! !**
```
# from:
%sudo   ALL=(ALL:ALL) ALL

# to:
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL
```

### Ansible

The few manual steps above is the only thing I've done manually, everything else is either ansible, or further down the line.

#### group_vars

* all.yml: Variables for all nodes
* k8s.yml: for k8s group only

#### inventory/k8s.yml

Contains all the details about your K8s environment.

Has 3 groups in it:

* k8s - all nodes
* control - K8s control plane node
* worker - K8s worker nodes

**! ! !**

`k8s0` is used in ansible as host name, so better not change it in inventory file.

#### common.all.yml

> common.all.yml split into 2: `debian` (_.deb_) and `rhel` (_.rpm_) based

Update packages to the latest version, add some bash aliases and bash completion for kubeadm and kubectl

```bash
ansible-playbook -i inventories/k8s.yml common.rhel.yml
```

#### k8s.yml - setup

Run initial setup steps to prepare nodes:

* Kernel modules
* Sysctl config
* Disable swap
* Add docker repo to apt
* Install containerd.io
* Add kubernetes repo to apt
* Install and hold kubeadm, kubectl and kubelet
* REBOOT

```bash
ansible-playbook -i inventories/k8s.yml k8s.yml -t setup
```

#### k8s.yml - init

Initialize K8s cluster:

```bash
ansible-playbook -i inventories/k8s.yml k8s.yml -t init
```

#### k8s.yml - join

Join worker nodes to the K8s cluster:

```bash
ansible-playbook -i inventories/k8s.yml k8s.yml -t join
```

#### k8s.reset.yml

Completely reset and uninstall K8s cluster - start from scratch:

```bash
ansible-playbook -i inventories/k8s.yml k8s.reset.yml -t reset
```

#### k8s.upgrade.yml

Upgrade K8s cluster to a selected version. Follow official [Upgrading kubeadm cluster](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/) documentation.

* `k8s_upgrade_version` - desired version to upgrade to

```bash
ansible-playbook -i inventories/k8s.yml k8s.upgrade.yml -t upgrade -e "k8s_upgrade_version=1.30.1"
```

## WSL

Local WSL setup.

### Pre-requisites (root)

```bash
apt update
apt install -y ansible
```

### Pre-requisites (user)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install

```bash
ansible-playbook -i inventories/wsl.yml wsl.yml
```
