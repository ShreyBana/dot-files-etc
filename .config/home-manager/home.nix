{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shrey_bana";
  home.homeDirectory = "/home/shrey_bana";

  programs.git = {
    enable = true;
    userName = "Shrey Bana";
    userEmail = "shreybana26@gmail.com";
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
  home.pointerCursor = {
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
    size = 26;
    x11.enable = true;
    gtk.enable = true;
  };
  
  home.packages = with pkgs; [
    libva-utils
    ocamlPackages.cpdf
    qpdf
    ghostscript
    ## Emacs 3rd party deps
    libtool
    gnumake
    cmake
    ##
    jetbrains.idea-community
    aider-chat-full
    tcpdump
    copilot-language-server-fhs
    jdt-language-server
    kotlin-language-server
    protonvpn-cli
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
    zed-editor
    unzip
    libgcc
    nixfmt-rfc-style
    nil
    nixd
    xmobar
    htop
    spotify
    direnv
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    awscli2
    kdePackages.okular
    flameshot
    nodePackages.typescript-language-server
    htop
    feh
    vlc
    xclip
    neovim
    ffmpeg-full
    simplescreenrecorder
    discord
    (writeShellScriptBin "record-gif" ''
      RESOLUTION=$(${pkgs.xorg.xrandr}/bin/xrandr --current | grep '\*' | awk '{print $1}')
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
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.rofi = {
    enable = true;
    cycle =  true;
    pass.enable = true;
    theme = "purple";
    plugins = with pkgs; [ rofi-emoji rofi-calc rofi-top ];
    font = "JetBrainsMono Nerd Font 15";
  };
  programs.librewolf.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles."default".userChrome = ''
      @-moz-document url(chrome://browser/content/browser.xhtml) {
      	/* tabs on bottom of window */
      	/* requires that you set
      	 * toolkit.legacyUserProfileCustomizations.stylesheets = true
      	 * in about:config
      	 * figure out current firefox's profile folder in about:support
      	 */
      	#main-window body { flex-direction: column-reverse !important; }
      	#navigator-toolbox { flex-direction: column-reverse !important; }
      	#urlbar {
      		top: unset !important;
      		bottom: calc(var(--urlbar-container-height) + 2 * var(--urlbar-padding-block)) !important;
      		box-shadow: none !important;
      		display: flex !important;
      		flex-direction: column !important;
      	}
      		#urlbar > * {
      			flex: none;
      		}
      	#urlbar .urlbar-input-container {
      		order: 2;
      	}
      	#urlbar > .urlbarView {
      		order: 1;
      		border-bottom: 1px solid #666;
      	}
      	#urlbar-results {
      		display: flex;
      		flex-direction: column-reverse;
      	}
      	.search-one-offs { display: none !important; }
      	.tab-background { border-top: none !important; }
      	#navigator-toolbox::after { border: none; }
      	#TabsToolbar .tabbrowser-arrowscrollbox,
      	#tabbrowser-tabs, .tab-stack { min-height: 28px !important; }
      	.tabbrowser-tab { font-size: 80%; }
      	.tab-content { padding: 0 5px; }
      	.tab-close-button .toolbarbutton-icon { width: 12px !important; height: 12px !important; }
      	toolbox[inFullscreen=true] { display: none; }
      	/*
      	 * the following makes it so that the on-click panels in the nav-bar
      	 * extend upwards, not downwards. some of them are in the #mainPopupSet
      	 * (hamburger + unified extensions), and the rest are in
      	 * #navigator-toolbox. They all end up with an incorrectly-measured
      	 * max-height (based on the distance to the _bottom_ of the screen), so
      	 * we correct that. The ones in #navigator-toolbox then adjust their
      	 * positioning automatically, so we can just set max-height. The ones
      	 * in #mainPopupSet do _not_, and so we need to give them a
      	 * negative margin-top to offset them *and* a fixed height so their
      	 * bottoms align with the nav-bar. We also calc to ensure they don't
      	 * end up overlapping with the nav-bar itself. The last bit around
      	 * cui-widget-panelview is needed because "new"-style panels (those
      	 * using "unified" panels) don't get flex by default, which results in
      	 * them being the wrong height.
      	 *
      	 * Oh, yeah, and the popup-notification-panel (like biometrics prompts)
      	 * of course follows different rules again, and needs its own special
      	 * rule.
      	 */
      	#mainPopupSet panel.panel-no-padding { margin-top: calc(-50vh + 40px) !important; }
      	#mainPopupSet .panel-viewstack, #mainPopupSet popupnotification { max-height: 50vh !important; height: 50vh; }
      	#mainPopupSet panel.panel-no-padding.popup-notification-panel { margin-top: calc(-50vh - 35px) !important; }
      	#navigator-toolbox .panel-viewstack { max-height: 75vh !important; }
      	panelview.cui-widget-panelview { flex: 1; }
      	panelview.cui-widget-panelview > vbox { flex: 1; min-height: 50vh; }
      }
    '';
    profiles."default".userContent = ''
      :root {
          --tridactyl-cmplt-font-size: 13px !important;
          --tridactyl-cmdl-font-size: 13px !important;
      }
    '';
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --sort type";
      ll = "eza --sort type --long";
      la = "eza --sort type --long --all";
      sd = "cd ~ && cd (fd --type d | fzf)";
      fcd = "cd (fd --type d | fzf)";
      hm-switch = "home-manager switch";
      xcp = "xclip -selection clipboard";
      xpaste = "xclip -selection clipboard -o";
      envr = "direnv reload";
      homesw = "home-manager switch";
      ossw = "sudo nixos-rebuild switch";
      nixgc = "sudo nix-collect-garbage -d";
    };
    interactiveShellInit = ''
    '';
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
    OPENROUTER_API_KEY = "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";
    CC = "${pkgs.stdenv.cc}";
    cc = "${pkgs.stdenv.cc}";
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-xft-dpi = 1;
      gtk-font-name = "Sans 14";
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-xft-dpi = 1;
      gtk-font-name = "Sans 14";
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
