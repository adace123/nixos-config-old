{
  description = "Home Manager NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, home-manager, ... }@inputs: {
    nixpkgs.overlays = [ (final: prev: { inherit nur; }) ];

    nixosConfigurations = {
      qemu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/vm/configuration.nix

          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.aaron = import ./home;
          #   extraSpecialArgs = { inherit inputs; };
          #   stateVersion = "21.11";
          #   nixpkgs.overlays = [ nur.overlay ];
          # }
        ];
      };
    };

    homeConfigurations = {
      aaron = home-manager.lib.homeManagerConfiguration {
        username = "aaron";
        system = "x86_64-linux";
        homeDirectory = "/home/aaron";
        configuration = import ./home;
        extraModules = [{
          nixpkgs = {
            overlays = [ nur.overlay ];
            config.allowUnfree = true;
          };
        }];
      };
    };
  };
}
