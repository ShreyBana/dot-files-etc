{ config, pkgs, ... }:

{
  home.username = "shrey_bana";
  home.homeDirectory = "/home/shrey_bana";
  programs.git = {
    enable = true;
    userName = "Shrey Bana";
    userEmail = "shreybana26@gmail.com";
  };

  home.packages = let
    nerdFonts = [
      "FiraCode"
      "DroidSansMono"
      "Hack"
      "RobotoMono"
      "JetBrainsMono"
      "Iosevka"
    ];
  in with pkgs; [
    libgcc
    nixfmt
    nil
    xmobar
    htop
    rofi
    spotify
    direnv
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    awscli2
    okular
    flameshot
    nodejs_18
    nodePackages.typescript-language-server
    (pkgs.nerdfonts.override { fonts = nerdFonts; })
    htop
    feh
    vlc
    xclip
    neovim
    alacritty 
    firefox-devedition-bin
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

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
    profiles."dev-edition-default".userChrome = ''
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
		bottom: calc(var(--urlbar-margin-inline)) !important;
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
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = { x = 2; y = 5; };
      };
    };
  };
  programs.tmux.enable = true;
  # programs.starship.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.fd.enable = true;
  programs.ripgrep.enable = true;
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
  home.sessionVariables = { EDITOR = "emacs"; };

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
