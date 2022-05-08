{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # use unstable nix so we can access flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc.automatic = true;
    settings.auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  # We expect to run the VM on hidpi machines.
  hardware.video.hidpi.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.cleanTmpDir = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "aaron-nixos";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp0s3.useDHCP = true;
    firewall.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
 
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # setup windowing environment
  services.xserver = {
    enable = true;
    layout = "us";
    dpi = 220;

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "scale";
    };

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
    };

    windowManager = {
      i3.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  users.users.aaron = {
      isNormalUser = true;
      home = "/home/aaron";
      hashedPassword = "$6$f1zH0EoA1X1PT4e1$8EhSLI8ugdmYkWrYlVFO.I1bA1GgRzbMAg7X5HxECaaHRviiCJ0dgu7sjRVwaycDZatAuPBZJg8EeZiF4CDNC1";
      extraGroups = [ "wheel" "networkmanager" "vboxsf" ];
      shell = pkgs.zsh;
  };

  # Manage fonts. We pull these from a secret directory since most of these
  # fonts require a purchase.
  fonts = {
    fontDir.enable = true;

    fonts = with pkgs; [
      fira-code
      jetbrains-mono
      roboto
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnumake
    killall
    xclip
    firefox
    curl
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.registry = lib.mapAttrs' (n: v:
    lib.nameValuePair (n) ({ flake = v; })
  ) inputs;
}
