# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  # config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  hardware.i2c.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.input-fonts.acceptLicense = true;
  nix.settings.trusted-users = [
    "root"
    "shrey_bana"
  ];
  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://ros.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.nixPath = [
    "nixos-config=/home/shrey_bana/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-3.18.0-unstable-2024-04-18"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.timeout = 10;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxPackages_6_17;
  services.udisks2.enable = true;
  services.devmon.enable = true; # If using a desktop environment
  networking.hostName = "section_pc"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.hosts = {
    "127.0.0.1" = [
      "localhost"
      "testsaml.app"
    ];
  };
  networking.wg-quick.interfaces = {
    protonvpn = {
      configFile = "/home/shrey_bana/.protonvpn.conf";
      autostart = false;
    };
  };
  services.resolved.enable = true;
  # services.dnsmasq = {
  #   enable = true;
  #   settings = {
  #     interface = "protonvpn";
  #   };
  # };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.keyboard.qmk.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  ## GRAPHICS
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # ROCm for GPU compute (OpenCL/HIP)
      rocmPackages.clr.icd
      rocmPackages.rocm-runtime
      # Video-Acc Lib: https://nixos.wiki/wiki/Accelerated_Video_Playback
      libvdpau-va-gl
    ];
  };
  # Enable Specialized Video-Drivers
  services.xserver.videoDrivers = [ "amdgpu" ];
  ##
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
  system.activationScripts.userAvatar = ''
    mkdir -p /var/lib/AccountsService/icons
    cp ${./.face} /var/lib/AccountsService/icons/shrey_bana
  '';
  programs.dconf.enable = true;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "doom"; # or "doom", "colormix", "none"
      animation_frame_delay = 30;
      bg = 0; # background color (0-8, ANSI palette)
      fg = 4; # foreground/text color
      border_fg = 4; # login box border color
      clock = "%c"; # show a clock, strftime format; empty string disables it
      hide_key_hints = false;
      asterisk = "*"; # character shown for password input
    };
  };
  services.xserver.displayManager.lightdm = {
    enable = false;
    greeters.slick = {
      enable = true;
      extraConfig = ''
        draw-grid=true
        show-hostname=true
        background=#4b495c
        content-align=center
        font-name=Ubuntu 16
        screen-reader=true
        xft-dpi=120
      '';
    };
  };
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
    config = builtins.readFile ./.xmonad.hs;
  };
  programs.river-next = {
    enable = true;
    localWindowManager = ./vendor/rijan-fork.nix;
    windowManagers = [ ];
    xwayland.enable = true;
    kanshi.enable = true;
  };
  services.picom = {
    backend = "glx";
    settings = {
      blur = {
        method = "dual_kawase";
        # size = 5;
        strength = 2;
        # deviation = 5.0;
      };
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
  services.logind.settings.Login = {
    IdleAction = "lock";
    IdleActionSec = 300;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      "org.freedesktop.portal.OpenURI" = {
        default = [ "firefox.desktop" ];
        preferred = [ "firefox.desktop" ];
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
      pkgs.input-fonts
      pkgs.lora
      pkgs.inter
      pkgs.source-serif-pro
      pkgs.source-sans-pro
      pkgs.nerd-fonts."m+"
      _0xproto
      fira-mono
      fira-code
      roboto-mono
      jetbrains-mono
      iosevka
      iosevka-term-slab
      hack
      commit-mono
      pkgs.ubuntu-sans-mono
      pkgs.hackgen-nf-font
      pkgs.iosevka-comfy.comfy-wide-motion-fixed
      pkgs.iosevka-comfy.comfy-duo
      pkgs.julia-mono
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
    wireplumber = {
      enable = true;
      extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.codecs" = [
            "ldac"
            "aptx"
            "aptx_ll_duplex"
            "aptx_ll"
            "aptx_hd"
            "aac"
            "sbc_xq"
          ];
        };
        # Disable suspend of Toslink output to prevent audio popping.
        # See: https://wiki.nixos.org/wiki/PipeWire#Sound_pops_a_few_seconds_after_playback_stops_OR_audio_takes_a_long_time_to_start_playing_after_a_couple_of_seconds
        "99-disable-suspend" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "node.name" = "~alsa_input.*";
                }
                {
                  "node.name" = "~alsa_output.*";
                }
              ];
              actions = {
                update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
          ];
        };
      };
    };
  };
  services.hardware.openrgb.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  users.users.shrey_bana = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "adbusers"
      "nginx"
      "systemd-journal"
      "video"
      "render"
      "i2c"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      via
      git
      tree
      alacritty
      xmobar
      rofi
    ];
  };
  services.emacs = {
    enable = lib.mkForce true;
    package = pkgs.emacs-pgtk;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # haskell.packages.ghc964.hoogle
    xsecurelock
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
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))
    miscfiles
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
  networking.firewall = {
    allowedTCPPorts = [
      22
      80
      443
      53
    ];
    allowedUDPPorts = [ 53 ];
    trustedInterfaces = [ "protonvpn" ];
    checkReversePath = "loose"; # Required for WireGuard
    extraCommands = ''
      ## Needed for Gazebo
      iptables -A INPUT -m pkttype --pkt-type multicast -j ACCEPT
    '';
  };
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
  # services.hoogle = {
  #   enable = true;
  #   port = 7777;
  #   haskellPackages = pkgs.haskell.packages.ghc964;
  #   packages =
  #     hpkgs: with hpkgs; [
  #       # Core essentials (top 10 most used)
  #       bytestring_0_12_2_0
  #       containers_0_8
  #       # transformer
  #       mtl_2_3_1
  #       text_2_1_2
  #       monadIO
  #       # deepseq
  #       # array
  #       # vector
  #       # hashable
  #       unordered-containers

  #       #   # JSON & data processing
  #       aeson
  #       #   aeson-pretty
  #       #   lens-aeson
  #       attoparsec
  #       #   megaparsec
  #       #   yaml
  #       #   binary

  #       #   # Optics (choose one ecosystem)
  #       lens # Full-featured (larger)
  #       #   # microlens microlens-platform  # Lightweight alternative

  #       #   # Web & HTTP
  #       http-types
  #       http-client
  #       #   servant
  #       #   warp
  #       #   scotty

  #       #   # Control & effects
  #       #   exceptions
  #       async
  #       stm_2_5_3_1

  #       #   # File & I/O
  #       #   directory
  #       #   filepath
  #       #   temporary
  #       #   conduit

  #       #   # Development & testing
  #       hspec
  #       HUnit
  #       #   tasty
  #       #   QuickCheck
  #       #   ghcid

  #       #   # Utilities
  #       time_1_14
  #       #   random
  #       #   scientific
  #       #   string-conversions
  #       network
  #       network-uri
  #       monad-logger

  #       #   # Common extensions you might use
  #       #   safe # Safe versions of partial functions
  #       #   extra # Extra functions
  #       #   split # String/list splitting utilities
  #     ];
  # };

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
