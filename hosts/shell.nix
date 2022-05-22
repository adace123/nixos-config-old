{ pkgs ? import (fetchTarball "https://github.com/nixos/nixpkgs/archive/nixos-unstable.tar.gz") {} }:
let
  nix = pkgs.writeShellScriptBin "nix" ''
    exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [ nix home-manager git ];
}
