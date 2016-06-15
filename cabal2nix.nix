/* Build instructions for the continuous integration system Hydra. */

{ cabal2nixSrc ? { outPath = ../cabal2nix; revCount = 0; gitTag = "dirty"; } }:

{

  cabal2nix = import ./generate-haskell-build.nix {
    gitSource = cabal2nixSrc;
    expressionPath = ./cabal2nix-pkg.nix;
    supportedCompilers = ["ghc763" "ghc784" "ghc7103" "ghc801"];
  };

}
