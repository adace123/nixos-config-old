{ pkgs, ... }:
let 
   alacritty-themes = pkgs.fetchFromGitHub {
    owner = "eendroroy";
    repo = "alacritty-theme";
    rev = "ade1c91";
    sha256 = "19bprgkmy08g58akijzwbfrmfipxzcdkvnadk5k94jklbjayiiff";
   };
   
   selectedTheme = "gruvbox_light";
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
