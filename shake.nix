/* Build instructions for the continuous integration system Hydra. */

{ shakeSrc ? { outPath = ../shake; revCount = 0; gitTag = "dirty"; } }:

{

  shake = import ./generate-haskell-build.nix {
    supportedCompilers = ["ghc722" "ghc742" "ghc763" "ghc784"];
    gitSource = shakeSrc;
    expressionPath = ./shake-pkg.nix;
  };

}
