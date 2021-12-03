# Fedora
### Basic setup
  - `sudo dnf install \https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm`
  - `sudo dnf install \https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`
  - `sudo dnf install vim`
  - `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
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

# Arch
### Installation steps
  - `iwctl` to enter cli
  - `device list` to show available stations
  - `station DEVICENAME connect SSID` connect to the network
  - `station DEVICENAME show` to check
  - `cfdisk` create root, swap & efi in ssd then make home in hdd
  - `mkfs.ext4 /dev/sdxY` for root & home
  - `mkfs.fat -F32 /dev/sdxY` for efi 
  - `mkswap /dev/sdxY` & `swapon /dev/sdxY` for swap
  - `mount /dev/sdxY /mnt` mount the root partition
  - `mkdir -p /mnt/boot/efi` create efi dir
  - `mount /dev/sdxY /mnt/boot/efi`
  - `mkdir /mnt/home` create home dir
  - `mount /dev/sdxY /mnt/home` mount linux home
  - `pacstrap /mnt linux linux-firmware base base-devel \`
    - `pacman-contrib efibootmgr networkmanager grub git \`
    - `lightdm lightdm-webkit2-greeter pulseaudio pulseaudio-alsa xorg-server alacritty vim \`
    - `ranger highlight w3m rofi feh \`
    - `nvidia nvidia-settings \`
    - `vlc firefox noto-fonts-emoji discord neofetch`
  - `genfstab -U /mnt >> /mnt/etc/fstab`
  - `arch-chroot /mnt`
  - `grub-install`
  - `grub-mkconfig -o /boot/grub/grub.cfg`
  - `systemctl enable NetworkManager`
  - `systemctl enable lightdm`
  - `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime`
  - `hwclock --systohc`
  -  Edit `/etc/locale.gen` and uncomment `en_US.UTF-8`.
  - `locale-gen`
  - Edit `/etc/hostname` & add hostname
  - Edit `/etc/hosts` & add `127.0.0.1       localhost`
  - `passwd` and set the root password
  - `groupadd sudo`
  -  edit `/etc/sudoers` and uncomment the `%sudo` line & make sure to leave the `%` 
  - `useradd -m USERNAME -c "FULL NAME"` to create new user with defaults (full name is used to at login).
  - `passwd USERNAME` to set the password
  - `usermod -aG sudo USERNAME` to enable **sudo** commands
  
### Install Yay
  - `pacman -S --needed git base-devel`
  - `git clone https://aur.archlinux.org/yay.git`
  - `cd yay`
  - `makepkg -si`

# Troubleshooting & Other Stuff:

### Fonts:
  - Arch package `otf-ipafont` for japanese fonts.
  - To change firefox font size of the toolbar use gtk-3.0 settings.

### GRUB
  - If you're not getting the grub menu on boot most probably grub wasn't properly installed so via the usb remount all the drives and re-install grub.
  - All changes to be made in `/etc/default/grub` and then run `sudo grub-mkconfig -o /boot/grub/grub.cfg`
  - If getting `funky smelling output from rdrand` on boot add `GRUB_CMDLINE_LINUX_DEFAULT=nordrand` to get the kernel to not use the `rdrand` instruction
  - If getting low res after installing a theme comment out `GRUB_TERMINAL_OUTPUT=console` via `#`
  - To run `os-prober` install the package and add the line `GRUB_DISABLE_OS_PROBER=false`.

### Dual-Boot Issues
  -  run `timedatectl set-local-rtc 1` to fix issues with time at boot 

### lightdm
  - `vim /etc/lightdm/lightdm.conf` uncomment under `[Seat:*]` the line containing `greeter-sesssion=` and put the name of the greeter you want to use ex: `greeter-session=lightdm-webkit2-greeter`

### Changing Your Shell
  - `sudo pacman -S fish`
  - `chsh -l` to check if its installed correctly
  - `chsh -s /usr/bin/fish` change default shell for current user
  - `fish_config` to run the default config script

### Changing `Full Name`
  - To change the GECO comment(used by gdm & lightdm for login user name aka `Full Name`), you have to edit `/etc/login.defs` to be able to make the appropriate change via `chfn`.

### Curosr
  - To change the size of the Xcursor edit the `~/.Xresources` and add `Xcursor.size: 32` or some power of 2.
  - To change the root/bg cursor to left pointer run `xsetroot -cursor_name left_ptr`
