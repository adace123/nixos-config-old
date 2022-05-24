{ pkgs, config, ... }:
let
  cfg = config.xsession.windowManager.i3;
in
{
  xsession.windowManager.i3 = {
    enable = true;
    
    package = pkgs.i3-gaps;

    config = {
      modifier = "Mod4";
      keybindings = cfg.config.keybindings.default;
     # keybindings = {
      #  "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";  
       # "${mod}+q" = "kill";
      #};
    };
  };
}
