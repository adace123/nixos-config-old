{ inputs, lib, config, pkgs, fonts, ... }:

{
  imports = [ 
    ./programs/alacritty.nix 
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.exa
    pkgs.fzf
    pkgs.neovim
  ];
}
