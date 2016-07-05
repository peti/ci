/* Build instructions for the continuous integration system Hydra. */

{ distributionNixpkgsSrc ? { outPath = ../distribution-nixpkgs; revCount = 0; gitTag = "dirty"; } }:

{

  distribution-nixpkgs = import ./generate-haskell-build.nix {
    gitSource = distributionNixpkgsSrc;
    expressionPath = ./distribution-nixpkgs-pkg.nix;
    supportedCompilers = ["ghc801"];
  };

}
