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
      aaron-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      aaron = home-manager.lib.homeManagerConfiguration {
        username = "aaron";
        system = "x86_64-linux";
        homeDirectory = "/home/aaron";
        configuration = ./home.nix;
      };
    };
  } // utils.lib.eachDefaultSystem (system: 
    let
      pkgs = import nixpkgs { inherit system; };
      nix = pkgs.writeShellScriptBin "nix" ''
        exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
      '';
      hm = home-manager.defaultPackage."${system}";
    in {
      packages = { nixpkgs = pkgs; };
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [ nix nixfmt rnix-lsp hm ];
      };
    });
}
