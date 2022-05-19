{ pkgs, ... }:
with import <nixpkgs> {};
let 
   themes = (import ./themes.nix {});
in
{
  home.file.".config/alacritty/colors".source = fetchFromGitHub {
    owner = "eenderoy";
    repo = "alacritty-theme";
    rev = "ade1c91";
    sha256 = "19bprgkmy08g58akijzwbfrmfipxzcdkvnadk5k94jklbjayiiff";
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
