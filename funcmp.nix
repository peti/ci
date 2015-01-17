/* Build instructions for the continuous integration system Hydra. */

{ funcmpSrc ? { outPath = ../funcmp; revCount = 0; gitTag = "dirty"; } }:

{

  funcmp = import ./generate-haskell-build.nix {
    gitSource = funcmpSrc;
    expressionPath = ./funcmp-pkg.nix;
  };

}
