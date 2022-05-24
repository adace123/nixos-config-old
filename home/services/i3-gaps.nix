{ pkgs, ... }:
{
  xsession.windowManager.i3 = {
    enable = true;
    
    modifier = "Mod4";

    package = pkgs.i3-gaps;

    #config = {
     # keybindings = {
      #  "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";  
       # "${mod}+q" = "kill";
      #};
    #};
  };
}
