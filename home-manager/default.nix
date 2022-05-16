{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];

  home.packages = [
    pkgs.xdg
  ];
}
