{ modulesPath, inputs, lib, config, pkgs, ... }: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/virtualisation/qemu-vm.nix")
    ./hardware-configuration.nix
    ../../modules/display/xserver.nix
  ];

  virtualisation = {
    diskSize = 75000; # MB
    memorySize = 4096; # MB
    writableStoreUseTmpfs = false;
    graphics = true;
  };

  # use unstable nix so we can access flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc.automatic = true;
  };

  nixpkgs.config.allowUnfree = true;

  # We expect to run the VM on hidpi machines.
  hardware.video.hidpi.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
      };
    };
  };

  networking = {
    hostName = "nixos-vm";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp0s3.useDHCP = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 22 ];
      allowedUDPPorts = [ 52 ];
      allowPing = true;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;

  users.users.aaron = {
    isNormalUser = true;
    home = "/home/aaron";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword =
      "$5$/nhm9p0UG6PMMe5t$0P/i5UAlQItu16yjr8h/Xw/qKDqp9nfHlys3sze0dmC";
    shell = pkgs.zsh;
  };

  users.extraUsers.root.password = "";

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
  environment.systemPackages = with pkgs; [ git home-manager ];
}
