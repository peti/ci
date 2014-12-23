/* Build instructions for the continuous integration system Hydra. */

{ largewordSrc ? { outPath = ../largeword; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? ["x86_64-linux"]
, supportedCompilers ? ["ghc6123" "ghc704" "ghc722" "ghc742" "ghc763" "ghc784" /*"ghcHEAD"*/]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
in
{
  largeword = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      Cabal = if pkgs.lib.versionOlder haskellPackages.ghc.version "7" then haskellPackages.Cabal_1_16_0_3 else null;
      cabal = haskellPackages.cabal.override { inherit Cabal; };
    in
    cabal.mkDerivation (self: {
      pname = "largeword";
      src = largewordSrc;
      version = largewordSrc.gitTag;
      buildDepends = with haskellPackages; [ binary ];
      testDepends = with haskellPackages; [
        binary HUnit QuickCheck testFramework testFrameworkHunit
        testFrameworkQuickcheck2
      ];
      meta = {
        homepage = "https://github.com/idontgetoutmuch/largeword";
        description = "Provides Word128, Word192 and Word256 and a way of producing other large words if required";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
        maintainers = [
          "Dominic Steinitz <dominic@steinitz.org>"
          "Peter Simons <simons@cryp.to>"
        ];
      };
    })));
}
