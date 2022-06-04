{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      darkreader
      privacy-badger
      tridactyl
    ];

  };
}
