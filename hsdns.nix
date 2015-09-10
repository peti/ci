/* Build instructions for the continuous integration system Hydra. */

{ hsdnsSrc ? { outPath = ../hsdns; revCount = 0; gitTag = "dirty"; } }:

{

  hsdns = import ./generate-haskell-build.nix {
    gitSource = hsdnsSrc;
    expressionPath = ./hsdns-pkg.nix;
  };

}
