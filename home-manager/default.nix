{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];
  home.packages = [
    python310
  ];
}
