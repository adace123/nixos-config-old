{ pkgs, ... }:
let
  mod = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    
    package = pkgs.i3-gaps;
    
    config = {
      "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";  
    };
  };
}
