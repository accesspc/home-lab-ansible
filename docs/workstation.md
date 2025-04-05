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

### Development

#### php

```sh
apt install -y composer php-cli php-mbstring php-mysql php-xml php-zip
```

#### cuda

```sh
apt install -y nvidia-cuda-toolkit
```

```sh

# multimedia
##
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
## https://rpmfusion.org/Howto/Multimedia
dnf swap -y ffmpeg-free ffmpeg --allowerasing
dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf install intel-media-driver libva-nvidia-driver libavcodec-freeworld

dnf install nvidia-vaapi-driver libva-utils vdpauinfo
dnf install vlc vlc-plugin-ffmpeg vlc-plugin-gstreamer vlc-plugins-freeworld

dnf install darktable darktable-tools-basecurve darktable-tools-noise gimp inkscape krita mkvtoolnix-gui qbittorrent HandBrake-gui

dnf install -y \
 gstreamer1-plugins-bad-freeworld \
 gstreamer1-plugins-good-extras \
 gstreamer1-plugins-ugly \
 gstreamer-plugins-espeak \
 libheif-freeworld \
 pipewire-codec-aptx


# libvirt
dnf install -y virt-manager
systemctl enable --now libvirtd.service

# wireguard
dnf install wireguard-tools
dnf install dhcp-server

```
