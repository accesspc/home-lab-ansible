# Workstation

## Kubuntu

Fresh minimal install with all updates.

### Pre-requisites

```sh
# as root
apt install -y ansible vim-nox

# select /usr/bin/vim.nox
update-alternatives --config editor

ubuntu-drivers install

reboot
```

### Tailscale

```sh
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --accept-routes
```

### Brew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc
```

### Run ansible

```sh
ansible-playbook -b -k -i inventories/workstation.yml workstation.yml

reboot
```

### DaVinci Resolve

```sh
# Download resolve linux zip
# Extract resolve linux zip
SKIP_PACKAGE_CHECK=1 ./DaVinci_Resolve_19.1.4_Linux.run
cd /opt/resolve/libs/
sudo mkdir disabled-libraries
sudo mv -v libglib* libgio* libgmodule* libgobject-* disabled-libraries/


sudo echo 'PrefersNonDefaultGPU=true' >> /usr/share/applications/com.blackmagicdesign.resolve.desktop
sudo echo 'X-KDE-RunOnDiscreteGpu=true' >> /usr/share/applications/com.blackmagicdesign.resolve.desktop

```
