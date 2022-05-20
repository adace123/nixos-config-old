{ pkgs, stdenv, ... }:
let 
   alacritty-themes = pkgs.fetchFromGitHub {
    owner = "eendroroy";
    repo = "alacritty-theme";
    rev = "ade1c91";
    sha256 = "19bprgkmy08g58akijzwbfrmfipxzcdkvnadk5k94jklbjayiiff";
   };
   
   selectedTheme = "gruvbox_dark";
   theme = (import ../../utils.nix { inherit stdenv; inherit pkgs; }).fromYAML "${alacritty-themes}/themes/${selectedTheme}.yaml";
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

      font = let fontname = "Hack Nerd Font Mono"; in {
	normal = { family = fontname; };
	bold = { family = fontname; style = "Bold"; };
        italic = { family = fontname; style = "Semibold Italic"; };
	size = 11;
      };

    } // theme;
  };
}
