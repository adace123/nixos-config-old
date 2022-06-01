{ pkgs, config, ... }:
let mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;

    package = pkgs.i3-gaps;

    config = {
      keybindings = {
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${mod}+q" = "kill";

        # workspace navigation
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
        "${mod}+Tab" = "workspace back_and_forth";

        # move containers to workspaces
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";

        "${mod}+Left" = "focus left";
        "${mod}+Right" = "focus right";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";

        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";

        "${mod}+minus" =
          "floating toggle; resize set 1000 600, move scratchpad";
        "${mod}+plus" = "scratchpad show; move position center";

        "${mod}+r" = ''mode "resize"'';
        "${mod}+Shift+Delete" = ''mode "system"'';

        "${mod}+XF86AudioPlay" =
          "exec ${pkgs.playerctl}/bin/playerctl play-pause";
      };

      modes = {
        resize = {
          "l" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize grow height 10 px or 10 ppt";
          "k" = "resize shrink height 10 px or 10 ppt";
          "h" = "resize grow width 10 px or 10 ppt";
          "Escape" = ''mode "default"'';
          "Return" = ''mode "default"'';
        };

        system = {
          "r" = "exec --no-startup-id reboot";
          "s" = "exec --no-startup-id shutdown now";
          "Escape" = ''mode "default"'';
          "Return" = ''mode "default"'';
        };
      };

      startup = [
        {
          command = "pgrep ${pkgs.brave}/bin/brave || ${pkgs.brave}/bin/brave";
          always = true;
          notification = false;
        }
        {
          command = "alacritty --class=alacritty-init";
          always = false;
          notification = false;
        }
      ];

      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 6;
        outer = 3;
      };

      window = {
        commands = [{
          command = "floating enable, resize set 1000 600, move to scratchpad";
          criteria = { instance = "alacritty"; };
        }];
      };

    };
  };
}
