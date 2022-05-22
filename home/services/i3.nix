{ pkgs, ... }:
let
  mod = "Mod4";
in
{
  programs.i3 = {
    enable = true;
    keybindings = {
      "${mod}+Return" = "exec ${pkgs.alacritty}";
    };
  };
}
