{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];

  home.stateVersion = "22.09";

  home.packages = [
    pkgs.python310
  ];
}
