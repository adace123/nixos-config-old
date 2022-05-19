{ pkgs, ... }:
let 
   themes = (import ./themes.nix {});
   repo = pkgs.fetchFromGitHub {
    owner = "eendroroy";
    repo = "alacritty-theme";
    rev = "ade1c91";
    sha256 = "19bprgkmy08g58akijzwbfrmfipxzcdkvnadk5k94jklbjayiiff";
   };

   alacritty-colorscheme = pkgs.python310Packages.buildPythonPackage {
     src = python310Packages.fetchPypi {
       pname = "alacritty-colorscheme";
       version = "1.0.1";
     };
     
     doCheck = false;
   };
in
{
  home.file.".config/alacritty/colors".source = "${repo}/themes";

  home.packages = with pkgs; [
    alacritty-colorscheme
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
