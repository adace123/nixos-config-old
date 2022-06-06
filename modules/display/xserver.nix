{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;

      layout = "us";

      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };
}
