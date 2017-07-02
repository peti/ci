/* Build instructions for the continuous integration system Hydra. */

{ hsyslogSrc ? { outPath = ../hsyslog; revCount = 0; gitTag = "dirty"; } }:

{

  hsyslog = import ./generate-haskell-build.nix {
    gitSource = hsyslogSrc;
    expressionPath = ./hsyslog-pkg.nix;
    supportedCompilers = ["ghc763" "ghc784" "ghc7103" "ghc802"];
  };

}
