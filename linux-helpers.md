# Fedora
### Basic setup
  `sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm`
  `sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`
  `sudo dnf install vim`
  `sudo dnf copr enable jerrycasiano/FontManager`
  `sudo dnf install font-manager`
  `sudo dnf groupinstall "Development Tools" "Development Libraries"`
  `sudo dnf install gnome-tweaks`
### Re-config grub menu
  `sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg`
  
### Remove & Limit Kernel installations
  `sudo dnf remove $(dnf repoquery --installonly --latest-limit=-2 -q)`
