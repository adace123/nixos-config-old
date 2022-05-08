{
  description = "Home Manager NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, utils, ... }@inputs: {
    nixosConfigurations = {
      aaron-nixos-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./nixos/vm/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      aaron = home-manager.lib.homeManagerConfiguration {
        username = "aaron";
        system = "x86_64-linux";
        homeDirectory = "/home/aaron";
        configuration = ./home-manage/home.nix;
      };
    };
  };
}
