{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];

  home.useGlobalPkgs = true;
  home.useUserPackages = true;

  home.packages = [
    pkgs.python310
  ];
}
