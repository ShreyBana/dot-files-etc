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
  - `mount /dev/sdxY /mnt` mount the root partition **IMP**
  - `mkdir -p /mnt/boot/efi` create efi dir **IMP**
  - `mount /dev/sdxY /mnt/boot/efi` mount the efi partiotion **IMP otherwise grub will not install**
  - `mkdir /mnt/home` create home dir **IMP**
  - `mount /dev/sdxY /mnt/home` mount linux home **IMP**
  - `pacstrap /mnt linux linux-firmware base base-devel  efibootmgr networkmanager grub git lightdm lightdm-webkit2-greeter pulseaudio pulseaudio-alsa xorg-server i3 alacritty vim ranger highlight w3m rofi nitrogen vlc firefox noto-fonts-emoji`
  - `genfstab -U /mnt >> /mnt/etc/fstab`
  - `arch-chroot /mnt`
  - `grub-install`
  - `grub-mkconfig -o /boot/grub/grub.cfg`
  - `systemctl enable NetworkManager`
  - `systemctl enable lightdm`
  - `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime`
  - `hwclock --systohc`
  -  Edit `/etc/locale.gen` and uncomment `en_US.UTF-8` then run `locale-gen`
  - `cat > /etc/hostname` & add hostname
  - `cat > /etc/hosts` & add `127.0.0.1       localhost`
  - `passwd` and set the root password
  - `groupadd sudo`
  -  edit `/etc/sudoers` and uncomment the `%sudo` line & make sure to leave the `%` 
  - `useradd -m USERNAME` to create new user with defaults
  - `passwd USER_NAME` to set the password
  - `usermod -aG sudo USERNAME` to enable **sudo** commands
  
### Install Yay
  - `cd Downloads`
  - `git clone https://aur.archlinux.org/yay-git.git`
  - `sudo chown -R <username>:<username> ./yay-git`
  - `cd yay-git`
  - `makepkg -si`
  - `cd ..; sudo rm -r yay-git`

# Optional Stuff:

### Fonts:
  - `yay -S nerd-fonts-hack nerd-fonts-roboto-mono` required for alacritty and polybar
  - `sudo pacman -S otf-ipafont` japanese fonts

### GRUB
  - All changes to be made in `/etc/default/grub` and then run `sudo grub-mkconfig -o /boot/grub/grub.cfg`
  - If getting `funky smelling output from rdrand` on boot add `GRUB_CMDLINE_LINUX_DEFAULT=nordrand` to get the kernel to not use the `rdrand` instruction
  - If getting low res after installing a theme comment out `GRUB_TERMINAL_OUTPUT=console` via `#`

### Dual-Boot issues
  -  run `timedatectl set-local-rtc 1` to fix issues with time at boot 

### fish
  - `sudo pacman -S fish`
  - `chsh -l` to check if its installed correctly
  - `chsh -s /usr/bin/fish` change default shell for current user
  - `fish_config` to run the default config script

### lightdm
  - `vim /etc/lightdm/lightdm.conf` uncomment under `[Seat:*]` the line containing `greeter-sesssion=` and put the name of the greeter you want to use ex: `greeter-session=lightdm-webkit2-greeter`
