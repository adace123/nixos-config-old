{ pkgs, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    
    package = pkgs.i3-gaps;

    options = {
      modifier = "Mod4";
    };
    
    config = {
      keybindings = {
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";  
        "${mod}+q" = "kill";
      };
    };
  };
}
