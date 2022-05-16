{ pkgs, ... }:
{
  home.packages = [
    pkgs.alacritty
  ];

  xdg.confgFile."alacritty/alacritty.yml".source = ./alacritty.yml;
}
