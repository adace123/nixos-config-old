{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./alacritty ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
