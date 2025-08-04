# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.nixPath = [
    "nixos-config=/home/shrey_bana/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.timeout = 10;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;  # If using a desktop environment
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.hosts = {
    "127.0.0.1" = [
      "localhost"
      "testsaml.app"
    ];
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.keyboard.qmk.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Configure keymap in X11
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "ctrl:swapcaps";
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableConfiguredRecompile = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
      haskellPackages.dbus
      haskellPackages.xmobar
      haskellPackages.xmonad-dbus
    ];
    config = builtins.readFile /home/shrey_bana/.xmonad.hs;
  };
  services.picom = {
    settings = {
      ## Causing hughe slow down.
      # blur =
      #   { method = "box";
      #     size = 5;
      #     deviation = 2.0;
      #   };
    };
    enable = true;
    fadeDelta = 3;
    opacityRules = [
      "90:class_g = 'Alacritty'"
      "90:class_g = 'Spotify'"
    ];
  };
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  programs.xss-lock.enable = true;
  programs.xss-lock.lockerCommand = "${pkgs.xsecurelock}/bin/xsecurelock";
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
        common = {
          default = ["gtk"];
        };
        "org.freedesktop.portal.OpenURI" = {
          default = ["firefox.desktop"];
          preferred = ["firefox.desktop"];
        };
      };
  };
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
  };

  ## FONTS
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Hack" ];
    };
    enableDefaultPackages = true;
    packages = with pkgs.nerd-fonts; [
      fira-mono
      roboto-mono
      jetbrains-mono
      iosevka
      hack
      pkgs.ubuntu-sans-mono
      pkgs.hackgen-nf-font
      pkgs.iosevka-comfy.comfy-wide-motion-fixed
      pkgs.iosevka-comfy.comfy-duo
    ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.hardware.openrgb.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  programs.adb.enable = true;
  users.defaultUserShell = pkgs.fish;
  users.users.shrey_bana = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "adbusers"
      "nginx"
      "systemd-journal"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      via
      git
      tree
      alacritty
      xmobar
    ];
  };
  services.emacs = {
    enable = true;
    package = pkgs.emacs30;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pinentry-all
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    bc
    unixtools.xxd
    via
    qmk
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    (aspellWithDicts (dicts: with dicts; [
      fr
      en
      en-computers
      en-science
    ]))
  ];
  services.udev.packages = [ pkgs.via ];
  environment.sessionVariables = {
    BROWSER = "firefox";
  };
  programs.firefox.enable = true;
  # programs.firefox.package = pkgs.


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-rofi;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  services.nginx = {
    enable = false;
    virtualHosts."testsaml.app" = {
      forceSSL = true;
      sslCertificate = "/etc/nginx/ssl/nginx.crt";
      sslCertificateKey = "/etc/nginx/ssl/nginx.key";
      locations."/" = {
        # Proxy to your actual service running on a higher port
        proxyPass = "http://localhost:8080";
      };
    };
    virtualHosts."test.devspaceworks.net" = {
      forceSSL = false;
      # sslCertificate = "/etc/nginx/ssl/nginx.crt";
      # sslCertificateKey = "/etc/nginx/ssl/nginx.key";
      locations."/" = {
        # Proxy to your actual service running on a higher port
        proxyPass = "http://localhost:8080";
      };
    };
    virtualHosts."localhost" = {
      forceSSL = true;
      sslCertificate = "/etc/nginx/ssl/nginx.crt";
      sslCertificateKey = "/etc/nginx/ssl/nginx.key";
      locations."/" = {
        # Proxy to your actual service running on a higher port
        proxyPass = "http://localhost:8080";
      };
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
