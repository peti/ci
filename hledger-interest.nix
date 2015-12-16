/* Build instructions for the continuous integration system Hydra. */

{ hledgerInterestSrc ? { outPath = ../hledger-interest; revCount = 0; gitTag = "dirty"; } }:

{

  hledger-interest = import ./generate-haskell-build.nix {
    gitSource = hledgerInterestSrc;
    expressionPath = ./hledger-interest-pkg.nix;
    supportedCompilers = ["ghc7103"];
  };

}
