/* Build instructions for the continuous integration system Hydra. */

{ hspecExpectationsSrc ? { outPath = ../hspec-expectations; revCount = 0; gitTag = "dirty"; }
, hspecSrc ? { outPath = ../hspec; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;

  peti = "Peter Simons <simons@cryp.to>";
  simon = "Simon Hengel <sol@typeful.net>";

  hspecExpectations = doCheck: genAttrs ["ghc6123" "ghc704" "ghc742" "ghc763" "ghcHEAD"] (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      myHspec = pkgs.lib.getAttrFromPath [ghcVer system] (hspec false);
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = pkgs.lib.optionalString (!doCheck) "untested-" + "hspec-expectations";
      src = hspecExpectationsSrc;
      version = hspecExpectationsSrc.gitTag;
      buildDepends = with haskellPackages; [ HUnit ];
      testDepends = with haskellPackages; [ myHspec HUnit markdownUnlit silently ];
      inherit doCheck;
      meta = {
        homepage = "https://github.com/sol/hspec-expectations#readme";
        description = "Catchy combinators for HUnit";
        license = self.stdenv.lib.licenses.mit;
        platforms = self.ghc.meta.platforms;
        maintainers = [simon peti];
      };
    })));

  hspec = doCheck: genAttrs ["ghc6123" "ghc704" "ghc742" "ghc763" "ghcHEAD"] (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      myHspecExpectations = pkgs.lib.getAttrFromPath [ghcVer system] (hspecExpectations doCheck);
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = pkgs.lib.optionalString (!doCheck) "untested-" + "hspec";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      isLibrary = true;
      isExecutable = true;
      buildDepends = with haskellPackages; [
        ansiTerminal deepseq filepath myHspecExpectations HUnit QuickCheck
        quickcheckIo random setenv time transformers
      ];
      testDepends = with haskellPackages; [
        ansiTerminal deepseq doctest filepath ghcPaths myHspecExpectations
        hspecMeta HUnit QuickCheck quickcheckIo random setenv silently time
        transformers
      ];
      inherit doCheck;
      meta = {
        homepage = "http://hspec.github.com/";
        description = "Behavior-Driven Development for Haskell";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
        maintainers = [simon peti];
      };
    })));
in
{
  hspecExpectations = hspecExpectations true;
  hspec = hspec true;
}
