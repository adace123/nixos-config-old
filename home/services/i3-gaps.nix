{ pkgs, ... }:
{
  xession.windowManager.i3 = rec {
    enable = true;
    
    mod = "Mod4";

    package = pkgs.i3-gaps;
    
    config = {
      "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";  
    };
  };
}
