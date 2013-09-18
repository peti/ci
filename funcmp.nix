/* Build instructions for the continuous integration system Hydra. */

{ funcmpSrc ? { outPath = ../funcmp; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? [ "ghc6104" "ghc6123" "ghc704" "ghc742" "ghc763" "ghcHEAD" ]
}:

let
  genAttrs = (import <nixpkgs> { system = "x86_64-linux"; }).lib.genAttrs;
in
rec {
  funcmp = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "funcmp";
      src = funcmpSrc;
      version = funcmpSrc.gitTag;
      meta.schedulingPriority = "200";  # build this package with a high priority
    })));
}
