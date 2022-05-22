{ pkgs, ... }:
let 
   alacritty-themes = pkgs.fetchFromGitHub {
    owner = "adace123";
    repo = "alacritty-themes";
    rev = "6147b56";
    sha256 = "1i0czz1h7bircwfd84njma7m1wm6p8w9g219xvaiz208pmjd6bw1";
   };
   
   selectedTheme = "catppuccin";
   theme = (import ../../utils.nix { inherit pkgs; }).fromYAML "${alacritty-themes}/themes/${selectedTheme}.yaml";
   fontFamily = "JetBrainsMono Nerd Font";
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      env = { TERM = "xterm-256color"; };
      window = {
        opacity = 0.8;
	dynamic_padding = true;
	dynamic_title = true;
	padding = {
          x = 6;
	  y = 6;
	};
      };

      mouse = { hide_when_typing = true; };

      font = {
        normal = { family = fontFamily; };
	bold = { family = fontFamily; style = "Bold"; };
	italic = { family = fontFamily; style = "Semibold Italic"; };
        size = 12;
      };

    } // theme;
  };
}
