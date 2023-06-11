# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:swapcaps";
 # services.xserver.xrandrHeads = [
 #  	{ 
 #       	output = "HDMI-1"; 
 #       	primary = true;
 #       }
 #  	{ 
 #       	output = "DP-1"; 
 #       	monitorConfig = ''
 #       		Option "Rotate" "right" 
 #       		Option "RightOf" "HDMI-1" 
 #       	''; 
 #       }
 #  ];

  services.xserver.windowManager.xmonad = {
	enable = true;
        enableConfiguredRecompile = true;
	enableContribAndExtras = true;
	#extraPackages = haskellPackages: [
	#  haskellPackages.xmobar
	#  haskellPackages.xmonad-dbus
	#];
	config = builtins.readFile /home/shrey_bana/.config/xmonad/xmonad.hs;
  };
  programs.xss-lock.enable = true;
  programs.xss-lock.lockerCommand = "${pkgs.xsecurelock}/bin/xsecurelock";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.fish.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shrey_bana = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # FONTS
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" "RobotoMono" "JetBrainsMono" "Iosevka" ]; })
      emacs-all-the-icons-fonts
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "JetBrainsMono" ];
      };
    };
  };


  # GIT
  programs.git.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    pulsemixer
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  environment.shellInit = ''export  NIX_PATH="$NIX_PATH:/nix/var/nix/profiles/per-user/$USER/channels"'';
}

