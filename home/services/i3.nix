{ pkgs, lib, ... }:
{
  programs.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod4";

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
      };
    };
  };
}
