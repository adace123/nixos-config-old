{ pkgs, lib, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {

      keybindings = {
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
      };
    };
  };
}
