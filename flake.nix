{
  description = "Home Manager NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      qemu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/vm/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      aaron = home-manager.lib.homeManagerConfiguration {
        username = "aaron";
        system = "x86_64-linux";
        homeDirectory = "/home/aaron";
        configuration = ./home;
      };
    };
  };
}
