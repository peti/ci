/* Build instructions for the continuous integration system Hydra. */

{ largewordSrc ? { outPath = ../largeword; revCount = 0; gitTag = "dirty"; } }:

{

  largeword = import ./generate-haskell-build.nix {
    gitSource = largewordSrc;
    expressionPath = ./largeword-pkg.nix;
  };

}
