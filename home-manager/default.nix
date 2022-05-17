{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];
  home.packages = [
    pkgs.python310
  ];
}
