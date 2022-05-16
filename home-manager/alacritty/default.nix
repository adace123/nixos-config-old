{ pkgs, ... }:
{
  home.pkgs = [
    pkgs.alacritty
  ];

  xdg.confgFile."alacritty/alacritty.yml".source = ./alacritty.yml;
}
