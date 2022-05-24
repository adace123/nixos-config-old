{ pkgs, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    
    package = pkgs.i3-gaps;

    config = {
      modifier = "Mod4";
     # keybindings = {
      #  "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";  
       # "${mod}+q" = "kill";
      #};
    };
  };
}
