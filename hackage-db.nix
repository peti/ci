/* Build instructions for the continuous integration system Hydra. */

{ hackageDbSrc ? { outPath = ../hackage-db; revCount = 0; gitTag = "dirty"; } }:

{

  hackageDb = import ./generate-haskell-build.nix {
    gitSource = hackageDbSrc;
    expressionPath = ./hackage-db-pkg.nix;
    supportedCompilers = ["ghc6123" "ghc704" "ghc722" "ghc742" "ghc763" "ghc784" /*"ghcHEAD"*/];
  };

}
