{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shrey_bana";
  home.homeDirectory = "/home/shrey_bana";
  programs.git = {
    enable = true;
    userName = "Shrey Bana";
    userEmail = "shrey.bana@juspay.in";
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # nixpkgs.overlays = [
  #   (self: super: {
  #     hls =
  #       let 
  #         easy-hls-src = super.fetchFromGitHub {
  #           owner  = "jkachmar";
  #           repo   = "easy-hls-nix";
  #           rev    = "6cb50f04e3a61b1ec258c6849df84dae9dfd763f";
  #           sha256 = "1rvi6067nw64dka8kksl7f34pwkq7wx7pnhnz3y261fw9z5j4ndp";
  #         };
  #       in
  #         super.callPackage easy-hls-src { ghcVersions = [ "8.8.4" ]; };
  #     })
  # ];
  #fonts.fontconfig.enable = true;
  home.packages =
    let 
      nerdFonts =
        [ "FiraCode"
          "DroidSansMono"
          "Hack"
          "RobotoMono"
          "JetBrainsMono"
          "Iosevka"
        ];
    in
     with pkgs; [
        emacs29
        htop
        starship
        rofi
        spotify
        rnix-lsp
        google-chrome-dev
        direnv
        lorri
        pamixer
        (pass.withExtensions (ext: with ext; [ pass-otp ]))
        awscli2
        playerctl
        pavucontrol
        pinentry
        postgresql_12
        okular
        flameshot
        fd
        ripgrep
        fzf
        nodejs_18
        nodePackages.typescript-language-server
        #(pkgs.nerdfonts.override { fonts = nerdFonts; })
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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shrey_bana/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
