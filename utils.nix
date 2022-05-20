{ pkgs }:
{
  fromYAML = path:
    let
      fileContents = builtins.readFile path;
      fileToJSON = pkgs.stdenv.mkDerivation {
        name = "fromYAML";
	phases = [ "buildPhase" ];
	buildPhase = "${pkgs.yaml2json}/bin/yaml2json < ${builtins.toFile "yaml" fileContents} > $out";
      };
    in
      builtins.fromJSON (builtins.readFile fileToJSON);
}
