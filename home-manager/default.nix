{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];

  home.packages = [
    pkgs.python310
    (pkgs.python310.withPackages (p: with p; [ pip ]))
  ];
}
