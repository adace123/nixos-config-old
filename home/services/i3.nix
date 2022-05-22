{ pkgs, ... }:
let
  mod = xsession.windowManager.i3.config.modifier;
in
{
  xsession.windowManager.i3.config = {
    keybindings = {
      "${mod}+Return" = "exec alacritty";
    };   
  };
}
