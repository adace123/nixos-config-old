{ pkgs, ... }:
let
  rofi-utils = pkgs.fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "7af63b1";
    sha256 = "1k3vr25gr40852mkig4glppv50z4ipa0yrrn60dsy0jy8rpc6kmp";
  };
in {
  xdg.configFile.rofi = {
    source = "${rofi-utils}/1080p";
    recursive = true;
  };

  programs.rofi = { enable = true; };
}
