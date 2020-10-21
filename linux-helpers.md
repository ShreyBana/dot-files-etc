# Fedora
### Basic setup
  - `sudo dnf install \https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm`
  - `sudo dnf install \https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`
  - `sudo dnf install vim`
  - `sudo dnf copr enable jerrycasiano/FontManager`
  - `sudo dnf install font-manager`
  - `sudo dnf groupinstall "Development Tools" "Development Libraries"`
  - `sudo dnf install gnome-tweaks`
  - `sudo dnf install discord`
  - `sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel`
  - `sudo dnf install lame\* --exclude=lame-devel`
  - `sudo dnf group upgrade --with-optional Multimedia`
  - `sudo dnf install zsh`
  - `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  - `sudo dnf install guake`
  
### Install Nvidia Non-free drivers
  `sudo dnf install akmod-nvidia`
  
### Re-config grub menu
  `sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg`
  
### Remove & Limit Kernel installations
  `sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)`
