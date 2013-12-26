/* Build instructions for the continuous integration system Hydra. */

{ hspecSrc ? { outPath = ../hspec; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;

  peti = "Peter Simons <simons@cryp.to>";
  simon = "Simon Hengel <sol@typeful.net>";
in
rec {
  hspec = genAttrs ["ghc704" "ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hspec";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      isLibrary = true;
      isExecutable = true;
      buildDepends = with haskellPackages; [
        ansiTerminal deepseq filepath hspecExpectations HUnit QuickCheck
        quickcheckIo random setenv time transformers
      ];
      testDepends = with haskellPackages; [
        ansiTerminal deepseq doctest filepath ghcPaths hspecExpectations
        hspecMeta HUnit QuickCheck quickcheckIo random setenv silently time
        transformers
      ];
      meta = {
        homepage = "http://hspec.github.com/";
        description = "Behavior-Driven Development for Haskell";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
        maintainers = [simon peti];
      };
    })
  ));

  hspecDiscoverIntegrationTest = genAttrs ["ghc704" "ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hspec-discover-integration-tests";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      isLibrary = true;
      noHaddock = true;
      postUnpack = "sourceRoot+=/hspec-discover/integration-test";
      preConfigure = "ln -s ../../Setup.lhs .";
      testDepends = [ (pkgs.lib.getAttrFromPath [ghcVer system] hspec) ];
      meta.maintainers = [simon peti];
    })
  ));

  hspecDiscoverExample = genAttrs ["ghc704" "ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hspec-discover-example";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      isLibrary = true;
      noHaddock = true;
      postUnpack = "sourceRoot+=/hspec-discover/example";
      preConfigure = "ln -s ../../Setup.lhs .";
      testDepends = [ (pkgs.lib.getAttrFromPath [ghcVer system] hspec) ];
      meta.maintainers = [simon peti];
    })
  ));
}