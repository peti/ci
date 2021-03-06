/* Build instructions for the continuous integration system Hydra. */

{ cabal2nixSrc ? { outPath = ../cabal2nix; revCount = 0; gitTag = "dirty"; } }:

{

  cabal2nix = import ./generate-haskell-build.nix {
    gitSource = cabal2nixSrc;
    expressionPath = ./cabal2nix-pkg.nix;
    supportedCompilers = ["ghc841"];
    supportedPlatforms = ["x86_64-linux" "x86_64-darwin"];
  };

}
