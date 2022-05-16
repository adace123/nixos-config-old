{ inputs, lib, config, pkgs, ... }:

{
  programs.exa.enable = true;
  programs.alacritty.enable = true;

  home.packages = [
    pkgs.neofetch
  ];
}
