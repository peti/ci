/* Build instructions for the continuous integration system Hydra. */

{ optparseApplicativeSrc ? { outPath = ../optparse-applicative; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc6123" "ghc704" "ghc722" "ghc742" "ghc763" "ghc782" "ghcHEAD"]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
  peti = "Peter Simons <simons@cryp.to>";
  paolo = "Paolo Capriotti <p.capriotti@gmail.com>";
in
{
  optparseApplicative = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "optparse-applicative";
      src = optparseApplicativeSrc;
      version = optparseApplicativeSrc.gitTag;
      buildDepends = with haskellPackages; [ ansiWlPprint transformers transformersCompat ];
      testDepends = with haskellPackages; [
        HUnit testFramework testFrameworkHunit testFrameworkQuickcheck2
        testFrameworkThPrime
      ];
      meta = {
        homepage = "https://github.com/pcapriotti/optparse-applicative";
        description = "Utilities and combinators for parsing command line options";
        license = self.stdenv.lib.licenses.bsd3;
        maintainers = [paolo peti];
      };
    })));
}
