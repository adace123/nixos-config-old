{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    package = pkgs.firefox.override {
      cfg = {
        enableTridactylNative = true;
        browser.pipewireSupport = true;
      };
    };

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      darkreader
      ublock-origin
      tridactyl
      rust-search-extension
      return-youtube-dislikes
    ];

    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "media.autoplay.enabled" = false;
      };
    };

  };

  xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
}
