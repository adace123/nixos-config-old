{ pkgs, ... }:
{
  services = {
    picom = {
      enable = true;
    };

    xserver = {
      enable = true;

      layout = "us";

      displayManager = {
        lightdm.enable = true;
      };
    };
  };
}
