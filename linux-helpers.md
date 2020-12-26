# Fedora
### Basic setup
  - `sudo dnf install \https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm`
  - `sudo dnf install \https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`
  - `sudo dnf install vim`
  - `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
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
  - `iwctl` to enter the netwrok manager icli
  - `station {devicename} connect SSID` connect to the network
  - `station {devicename} show` to check
  - `cfdisk` create root, swap & efi in ssd then make home in hdd
  - `mkfs.ext4 /dev/sdxY` for root & home
  - `mkfs.fat -F32 /dev/sdxY` for efi 
  - `mkswap /dev/sdxY` & `swapon /dev/sdxY` for swap
  - `mount /dev/sdxY /mnt` mount the root partition
  - `mkdir /mnt/boot; mkdir /mnt/boot/efi` create efi dir
  - `mount /dev/sdxY /mnt/boot/efi` mount the efi partiotion
  - `mkdir /mnt/home` create home dir 
  - `mount /dev/sdxY /mnt/home` mount linux home
  - `pacstrap /mnt base base-devel linux linux-firmware vim alacritty NetworkManager`
  - `genfstab -U /mnt >> /mnt/etc/fstab`
  - `arch-chroot /mnt`
  - `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime`
  - `hwclock --systohc`
  -  Edit `/etc/locale.gen` and uncomment `en_US.UTF-8` then run `locale-gen`
  - `cat > /etc/hostname` & add hostname
  - `cat > /etc/hosts` & add `127.0.0.1       localhost`
  - `passwd` and set the root password
  - `adduser {username}` create a user
  - `passwd {username}` set password 
  - `groupadd sudo`
  -  edit `/etc/sudoers` and uncomment the `%sudo` line 
  - `usermod -a -G sudo {username}`
  - `pacman -S grub efibootmgr`
  - `grub-install`
  - `grub-mkconfig -o /boot/grub/grub.cfg`
