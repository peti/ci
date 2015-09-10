/* Build instructions for the continuous integration system Hydra. */

{ nixPathsSrc ? { outPath = ../nix-paths; revCount = 0; gitTag = "dirty"; } }:

{

  nix-paths = import ./generate-haskell-build.nix {
    gitSource = nixPathsSrc;
    expressionPath = ./nix-paths-pkg.nix;
  };

}
