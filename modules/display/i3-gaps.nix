{ pkgs, ... }:
{
  programs.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };

  programs.xserver.enable = true;
}
