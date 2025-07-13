# Proxmox setup

## ISO

* Download ISO from [here](https://www.proxmox.com/en/downloads)
* Put ISO on Ventoy USB
* Boot from Ventoy
* Select proxmox-ve
* Install

Results

* Proxmox node IP

## Proxmox subscription

Update apt sources to use `pve-no-subscription` repos using Ansible:

```bash
ansible-playbook -i inventories/home.yml -l pve common.debian.yml
```

Reboot

## Network

* Browse to Proxmox VE UI: https://PROXMOX_IP:8006/
* Datacenter -> Node -> System -> Network - sort out interfaces

## TLS for Web UI

```bash
apt install -y python3-certbot-dns-cloudflare
```

* Browse to Proxmox VE UI: https://PROXMOX_IP:8006/
* Login as root
* Datacenter -> ACME
    * Accounts -> Add
        * [Cloudflare Account ID](https://developers.cloudflare.com/fundamentals/account/find-account-and-zone-ids/)
    * Challenge Plugins -> Add
* Datacenter -> Node -> System -> Certificates -> ACME
    * Add
    * Order Certificate Now

## Cluster

* Browse to Proxmox VE UI: https://PROXMOX_IP:8006/
* Datacenter -> Cluster
    * Create Cluster

## Locales

Update locales and fix some `LC_*` issues

```bash
dpkg-reconfigure locales
```
