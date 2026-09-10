{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = "shrey_bana";
  # home.homeDirectory = "/home/shrey_bana";
  # in home.nix
  # xdg.configFile."rijan/init.janet".source = ./rijan-init.janet;
  wayland.systemd.target = "river-session.target";
  systemd.user.sessionVariables.GDK_BACKEND = "wayland";
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Shrey Bana";
        email = "shreybana26@gmail.com";
      };
      aliases = {
        c = "commit";
        fa = "fetch --all";
        Fu = "fetch upstream HEAD";
        Fum = "fetch upstream main";
        Fo = "fetch origin HEAD";
        Fom = "fetch origin main";
        pu = "push upstream HEAD";
        po = "push origin HEAD";
        co = "checkout";
        s = "status";
      };
      extraConfig = {
        push = {
          autoSetupRemote = true;
        };
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    size = 26;
    x11.enable = true;
    gtk.enable = true;
  };

  services.swayidle = {
    enable = true;

    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
      lock = "${pkgs.swaylock}/bin/swaylock -f";
    };

    timeouts = [
      {
        timeout = 270;
        command = "${pkgs.libnotify}/bin/notify-send -e 'Swayidle' 'Staging lock due to inactivity.'";
      }
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      # {
      #   timeout = 40;
      #   command = "${pkgs.systemd}/bin/systemctl suspend";
      # }
    ];
  };
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = true;

      color = "000000";
      font = "JetBrains Mono";
      font-size = 22;

      # thin, big ring — the ly-style outline look
      # indicator = true;
      indicator-radius = 120;
      indicator-thickness = 4;

      # transparent fills so only the ring/line show, not a solid blob
      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      inside-caps-lock-color = "00000000";

      # ring stays monochrome across states, just brightness shifts
      ring-color = "333333";
      ring-clear-color = "555555";
      ring-ver-color = "00ff00";
      ring-wrong-color = "ff0000";
      ring-caps-lock-color = "ffff00";

      # line fully transparent so it doesn't break the ring visually
      line-color = "00000000";
      line-clear-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      line-caps-lock-color = "00000000";

      # text transparent by default, only shows meaningfully on state change
      text-color = "00ff00";
      text-clear-color = "00000000";
      text-ver-color = "00ff00";
      text-wrong-color = "ff0000";
      text-caps-lock-color = "ffff00";

      key-hl-color = "00ff00";
      bs-hl-color = "ff0000";
      caps-lock-key-hl-color = "ffff00";
      caps-lock-bs-hl-color = "ff0000";

      separator-color = "00000000";

      layout-bg-color = "000000";
      layout-text-color = "00ff00";

      disable-caps-lock-text = false;
      indicator-caps-lock = true;
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    libnotify
    swaybg
    ipe
    jupyter
    vips
    realesrgan-ncnn-vulkan
    claude-code
    claude-agent-acp
    pciutils
    dmidecode
    lm_sensors
    texliveMedium
    clang-tools
    qgroundcontrol
    neocmakelsp
    libva-utils
    qpdf
    ghostscript
    ## Emacs 3rd party deps
    libtool
    gnumake
    cmake
    ##
    # jetbrains.idea-community
    # aider-chat-full
    tcpdump
    copilot-language-server
    jdt-language-server
    kotlin-language-server
    gitu
    gcc
    rust-analyzer
    openssl
    ispell
    btop
    spotify-cli-linux
    mesa-demos
    nemo
    pulsemixer
    tldr
    # zed-editor
    unzip
    libgcc
    nixfmt
    nil
    nixd
    htop
    spotify
    direnv
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    awscli2
    kdePackages.okular
    flameshot
    typescript-language-server
    htop
    feh
    vlc
    xclip
    neovim
    ffmpeg-full
    simplescreenrecorder
    discord
    (writeShellScriptBin "screenshot" ''
      mkdir -p ~/screenshots
      filename="screenshot-$(date +%Y%m%d-%H%M%S).png"
      ${pkgs.scrot}/bin/scrot ~/screenshots/"$filename"
      ${pkgs.libnotify}/bin/notify-send "Screenshot" "Saved as $filename"
    '')
    (writeShellScriptBin "record-gif" ''
      RESOLUTION=$(${pkgs.xrandr}/bin/xrandr --current | grep '\*' | awk '{print $1}')
      TMP_VIDEO=$(mktemp --suffix=.mp4)
      OUTPUT_GIF=$(mktemp --suffix=.gif)

      echo "Recording screen... Press q to stop."
      ${pkgs.ffmpeg-full}/bin/ffmpeg -loglevel error -y -f x11grab -video_size $RESOLUTION -framerate 15 -i :0.0 -c:v libx264 -preset ultrafast $TMP_VIDEO

      echo "Converting to GIF..."
      ${pkgs.ffmpeg-full}/bin/ffmpeg -loglevel error -y -i $TMP_VIDEO -vf "fps=10,scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" $OUTPUT_GIF
      echo $OUTPUT_GIF | ${pkgs.xclip}/bin/xclip -selection clipboard

      echo "Done! GIF saved to $OUTPUT_GIF & copied the path to clipboard!"
      rm $TMP_VIDEO
    '')
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # ;
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  # };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.package = pkgs.adwaita-qt;
  };

  programs.sioyek = {
    enable = true;
    bindings = {
      "screen_down" = [
        "d"
        "<C-d>"
      ];
      "screen_up" = [
        "u"
        "<C-u>"
      ];
      "move_left" = "h";
      "move_right" = "l";
      "copy" = "y";
    };
    config = {
      "font_size" = "18";
      "status_bar_font_size" = "18";
      "background_color" = "1.0 1.0 1.0";
      #   "text_highlight_color" = "1.0 0.0 0.0";
      startup_commands = [
        "toggle_dark_mode"
        "toggle_visual_scroll"
      ];
    };
  };

  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "/home/shrey_bana/dot-files-etc/pictures/wallpapers";
        duration = "4h";
        sorting = "random";
        queue-size = 100;
      };
    };
  };
  systemd.user.services.wpaperd.Service.Environment = "RUST_LOG=debug";
  systemd.user.services.waybar.Unit.StartLimitBurst = 10;
  systemd.user.services.waybar.Unit.StartLimitIntervalSec = 5;
  systemd.user.services.waybar.Service.RestartSec = 2;
  programs.waybar = {
    systemd.enable = true;
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 23;

        modules-left = [
          "custom/rijan"
        ];
        modules-center = [ "mpris" ];
        modules-right = [
          "network"
          "disk"
          "cpu"
          "memory"
          # "battery"
          "pulseaudio"
          "clock"
        ];

        "custom/rijan" = {
          exec = "cat $XDG_RUNTIME_DIR/rijan/status.json";
          interval = 0.1;
          return-type = "json";
        };

        mpris = {
          format = "{status_icon} {dynamic}"; # play/pause/stop icon via status-icons, already set
          status-icons = {
            playing = "";
            paused = "󰏤";
            stopped = "";
          };
        };

        network = {
          format-wifi = "󰀂 {essid}"; # wifi icon
          format-ethernet = "  U:{bandwidthUpBytes} D:{bandwidthDownBytes}"; # ethernet icon
          format-disconnected = " disconnected";
          interval = 2;
          tooltip = false;
        };

        disk = {
          path = "/";
          format = " {used}"; # disk/hdd icon
          interval = 5;
        };

        cpu = {
          format = "CPU: {usage}%"; # chip icon
          interval = 3;
        };

        memory = {
          format = "MEM: {used:0.1f}G/{total:0.1f}G"; # memory icon
          interval = 3;
        };

        battery = {
          format = "{icon} {capacity}%"; # icon cycles by charge level automatically
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ]; # empty -> full
          format-charging = " {capacity}%"; # bolt icon while charging
          interval = 10;
        };

        pulseaudio = {
          format = "󰕾 {volume}%"; # speaker icon
          format-muted = "󰝟 muted"; # muted-speaker icon
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        };

        clock = {
          format = "  {:%a, %d-%m-%Y  %H:%M:%S}"; # clock icon
          interval = 1;
        };
      };
    };
    style = builtins.readFile ./waybar.css;
  };
  programs.xmobar = {
    enable = true;
    extraConfig = builtins.readFile ./xmobarrc;
  };
  programs.rofi = {
    enable = true;
    cycle = true;
    pass.enable = true;
    theme = "purple";
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
      rofi-top
    ];
    font = "JetBrainsMono Nerd Font 15";
  };
  # programs.librewolf.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      l = "less";
      ls = "eza --sort type";
      ll = "eza --sort type --long";
      la = "eza --sort type --long --all";
      sd = "cd ~ && cd (fd --type d | fzf)";
      fcd = "cd (fd --type d | fzf)";
      hm-switch = "home-manager switch";
      xcp = "xclip -selection clipboard";
      xpaste = "xclip -selection clipboard -o";
      envr = "direnv reload";
      ossw = "sudo nixos-rebuild switch --flake ~/dot-files-etc#section_pc";
      nixgc = "sudo nix-collect-garbage -d";
    };
    functions = {
      fish_prompt.body = builtins.readFile ./fish-prompt.fish;
    };
    interactiveShellInit = "";
  };
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 2;
          y = 10;
        };
      };
      font = {
        size = 15;
      };
    };
  };
  programs.kickoff.enable = true;
  programs.starship.enable = false;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.fd.enable = true;
  programs.ripgrep.enable = true;
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      default_layout = "compact";
      theme = "solarized-dark";
    };
  };
  programs.bat.enable = true;
  programs.lazygit.enable = true;

  programs.zathura = {
    enable = true;
    options = {
      # General settings
      sandbox = "none"; # Disable sandboxing for better compatibility
      selection-clipboard = "clipboard"; # Use system clipboard
      window-title-basename = true; # Only show filename in window title
      statusbar-home-tilde = true; # Show ~ for home directory

      # Appearance
      font = "Hack Nerd Font 15"; # Font for the interface
      default-bg = "#161417"; # Background color
      default-fg = "#efd5c5"; # Foreground color

      # Interface colors
      statusbar-bg = "#675072"; # Status bar background
      statusbar-fg = "#fedeff"; # Status bar foreground
      inputbar-bg = "#675072"; # Input bar background
      inputbar-fg = "#fedeff"; # Input bar foreground

      # Highlighting colors
      # highlight-color = "#5294e2";       # Search highlighting color
      # highlight-active-color = "#ff5555"; # Current search result

      # Highlighting colors
      highlight-color = "#d0995080"; # Search highlighting color with alpha (80 = 50% opacity)
      highlight-active-color = "#c0b24f80"; # Current search result with alpha
      highlight-transparency = 0.5; # Set transparency for highlights

      # Recolor settings (optional dark mode)
      recolor = true; # Set to true to enable dark mode by default
      recolor-darkcolor = "#efd5c5"; # Dark mode text color
      recolor-lightcolor = "#232025"; # Dark mode background color

      # Additional settings
      page-padding = 1; # Padding between pages
      pages-per-row = 1; # Pages displayed in a row
      scroll-step = 50; # Scroll step size
      scroll-page-aware = true; # Smart scrolling for multi-page documents
      adjust-open = "best-fit"; # Initial zoom level

      # Synctex support (if you use LaTeX)
      synctex = false; # Set to true if you use LaTeX with synctex
      synctex-editor-command = "code %{input}:%{line}"; # Change to your editor
    };

    # Custom key mappings
    extraConfig = ''
      # Zoom in/out with + and -
      map + zoom in
      map - zoom out
      map = zoom 100

      # Rotate the document
      map r rotate

      # Toggle recolor (dark mode)
      map <C-r> recolor

      # Toggle fullscreen
      map [fullscreen] a adjust_window best-fit
      map [fullscreen] s adjust_window width

      # Copy text to clipboard
      map y selection_clipboard clipboard
    '';
  };

  services.dunst.enable = true;
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shrey_bana/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "zeditor";
    BROWSER = "firefox";
    CC = "${pkgs.stdenv.cc}";
    cc = "${pkgs.stdenv.cc}";
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.inter;
      name = "Inter";
      size = 16;
    };
    gtk3.extraConfig = {
      gtk-xft-dpi = 1;
      # gtk-font-name = "Sans 14";
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-xft-dpi = 1;
      # gtk-font-name = "Sans 14";
      gtk-application-prefer-dark-theme = true;
    };
  };
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [pkgs.xdg-desktop-portal-gtk];
  # };
  # xdg.mime.enable = true;
  # xdg.mimeApps = {
  #     enable = true;
  #     defaultApplications = {
  #       "text/html" = ["firefox.desktop"];
  #       "x-scheme-handler/http" = ["firefox.desktop"];
  #       "x-scheme-handler/https" = ["firefox.desktop"];
  #     };
  #   };

  programs.firefox = {
    enable = true;
    # configPath = "~/.mozilla/firefox";
    configPath = "/home/shrey_bana/.mozilla/firefox";
    profiles."default" = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "permissions.default.shortcuts" = 0; # # `2` to disallow re-bidning of shortcuts
      };
    };
    profiles."default".userChrome = builtins.readFile ./userChrome.css;
    profiles."default".userContent = ''
      :root {
          --tridactyl-cmplt-font-size: 14px !important;
          --tridactyl-cmdl-font-size: 14px !important;
      }
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
