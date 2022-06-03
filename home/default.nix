{ inputs, lib, config, pkgs, fonts, ... }:

{
  imports =
    [ ./programs/alacritty.nix ./services/i3-gaps.nix ./programs/rofi.nix ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    exa
    fzf
    neovim
    brave
  ];
}
