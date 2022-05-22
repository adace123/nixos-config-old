{ inputs, lib, config, pkgs, fonts, ... }:

{
  imports = [ ./alacritty ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.exa
    pkgs.fzf
  ];
}
