/* Build instructions for the continuous integration system Hydra. */

{ hackageDbSrc ? { outPath = ../hackage-db; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? [ "ghc6104" "ghc6123" "ghc704" "ghc722" "ghc742" "ghc763" "ghc784" "ghcHEAD" ]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
in
rec {
  hackageDb = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell-ng" "packages" ghcVer] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hackageDb";
      src = hackageDbSrc;
      buildDepends = with haskellPackages; [ Cabal filepath tar utf8String ];
      version = hackageDbSrc.gitTag;
    })));
}
