{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "shrey_bana";
  home.homeDirectory = "/home/shrey_bana";
  programs.git = {
    enable = true;
    userName = "Shrey Bana";
    userEmail = "shreybana26@gmail.com";
    aliases = {
      co = "checkout";
      s  = "status";
    };
  };
  home.packages = with pkgs; [
    htop
    starship
    rofi
    rnix-lsp
    direnv
    lorri
    emacs
    firefox-devedition-bin
    feh
    alacritty
    spotify
    tmux
    exa
    picom
    vlc
    xclip
  ];
  # This value determines the Home Manager release that your configuration is
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
