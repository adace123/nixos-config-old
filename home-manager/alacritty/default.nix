{ alacrittyTheme ? "catpuccin", pkgs, ... }:
let 
   themes = (import ./themes.nix {});
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

      colors = themes.${alacrittyTheme};
    };
  };
}
