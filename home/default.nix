{ inputs, lib, config, pkgs, fonts, ... }:

{
  imports = [
    ./programs/alacritty
    ./services/i3-gaps
    ./programs/rofi
    ./programs/firefox
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    exa
    fzf
    neovim
  ];
}
