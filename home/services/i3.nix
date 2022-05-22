{ pkgs, ... }:
let
  mod = "Mod4";
in
{
  services.i3 = {
    keybindings = {
      "${mod}+Return" = "exec ${pkgs.alacritty}";
    };
  };
}
