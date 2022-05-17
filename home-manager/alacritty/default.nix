{ pkgs, fetchFromGitHub, ... }:
let 
   themes = (import ./themes.nix {});
in
{
  home.file.".config/alacritty/colors" = fetchFromGitHub {
    owner = "eenderoy";
    repo = "alacritty-theme";
    rev = "master";
    sha256 = "ade1c9114cf37d0239c3499b74c8196cf1e6aee4";
  };

  home.packages = with pkgs; [
    python310Packages.alacritty-colorscheme
  ];

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

      colors = themes.gruvbox_dark;
    };
  };
}
