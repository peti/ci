/* Build instructions for the continuous integration system Hydra. */

{ languageNixSrc ? { outPath = ../language-nix; revCount = 0; gitTag = "dirty"; } }:

{

  language-nix = import ./generate-haskell-build.nix {
    gitSource = languageNixSrc;
    expressionPath = ./language-nix-pkg.nix;
    supportedCompilers = ["ghc7102"];
  };

}
