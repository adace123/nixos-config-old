{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];

  home.stateVersion = "22.05";

  home.packages = [
    pkgs.python310
  ];
}
