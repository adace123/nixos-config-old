{ inputs, lib, config, pkgs, fonts, ... }:

{
  imports = [ 
    ./programs/alacritty.nix 
    ./services/i3-gaps.nix
  ];

  xsession.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.exa
    pkgs.fzf
    pkgs.neovim
  ];
}
