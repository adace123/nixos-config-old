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

    sharedDirectories = {
      nixos-config = {
        source = "/home/aaron/nixos-config";
        target = "/mnt/nixos-config";
      };
    };

    forwardPorts = [{
      from = "host";
      host.port = 2222;
      guest.port = 22;
    }];
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
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDY/cDE4jLKzlng2ihxAW9Xnv4YrrUnNeaBdNtWqpHfVIZyveCr7NIFZ9bsgKYRrBFoQhs8fNNPdexXqXxLwiPe+JO3BGWMNH71fB8hixIC+c6CcYNVpEQxKdW3EJONeRGovYlIVsgNf4DgUgnoEwBSh6N0yuEHkHK64kYt6VTkLHFW+Gryefuuuzv9roMJ3vYtWxd40rkVPIOVqnGC4n7nDrDXvy3A9Dy7RHVKfgASrI83xJvm9x+CEnzmLi+Gco7HXo8h+fmYc3XqTlsfZVAielzJuaiDTZEbkL9Hi/HsWj9YkxS7gj/+fETigMHgP8vDwsFcLMESh1kvsgQXU9HyFD2cX2mezRKTaVjSOiNPM+oVJu7pwu0uwgFZ/pKo6G/B3+5jQ3cRazXeNnhtAF9n0QvusKW17I/LepS8IvxeHBdDx9RZB4eRZQt9bto0QqnoKqJD1ivduH8gSDqPRXCC5ji1xSkbby5hnkBYQNF87NBI++AjrzdgynMvv4MO4bM= aaron@aaron-endeavouros"

    ];
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  users.extraUsers.root.password = "";

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
  environment.systemPackages = with pkgs; [ git home-manager vim ];
}
