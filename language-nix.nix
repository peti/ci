/* Build instructions for the continuous integration system Hydra. */

{ languageNixSrc ? { outPath = ../language-nix; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc742" "ghc763" "ghc784" /*"ghcHEAD"*/]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
in
{
  languageNix = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "language-nix";
      src = languageNixSrc;
      version = languageNixSrc.gitTag;
      isLibrary = true;
      isExecutable = true;
      buildDepends = with haskellPackages; [ mtl QuickCheck transformers uuParsinglib parsec ];
      testDepends = with haskellPackages; [ doctest hspec HUnit mtl QuickCheck transformers uuParsinglib parsec ];
      meta = {
        homepage = "https://github.com/peti/language-nix";
        description = "Haskell AST and Parsers for the Nix language";
        license = self.stdenv.lib.licenses.bsd3;
        maintainers = [ self.stdenv.lib.maintainers.simons ];
      };
    })
  ));
}
