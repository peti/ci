/* Build instructions for the continuous integration system Hydra. */

{ hspecSrc ? { outPath = ../hspec; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc704" "ghc722" "ghc742" "ghc763" "ghc783"]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;

  peti = "Peter Simons <simons@cryp.to>";
  simon = "Simon Hengel <sol@typeful.net>";
in
rec {
  hspecCore = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hspec-core";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      postUnpack = "sourceRoot+=/hspec-core";
      buildDepends = with haskellPackages; [
        ansiTerminal async deepseq hspecExpectations HUnit QuickCheck
        quickcheckIo random setenv tfRandom time transformers
      ];
      testDepends = with haskellPackages; [
        ansiTerminal async deepseq ghcPaths hspecExpectations hspecMeta
        HUnit QuickCheck quickcheckIo random setenv silently tfRandom time
        transformers
      ];
      meta = {
        homepage = "http://hspec.github.io/";
        description = "A Testing Framework for Haskell";
        license = self.stdenv.lib.licenses.mit;
        platforms = self.ghc.meta.platforms;
      };
    })
  ));

  hspecDiscover = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hspec-discover";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      postUnpack = "sourceRoot+=/hspec-discover";
      buildDepends = with haskellPackages; [
        (pkgs.lib.getAttrFromPath [ghcVer system] hspecCore)
        filepath transformers
      ];
      testDepends = with haskellPackages; [
        filepath hspecMeta stringbuilder transformers
      ];
      meta = {
        homepage = "http://hspec.github.io/";
        description = "Automatically discover and run Hspec tests";
        license = self.stdenv.lib.licenses.mit;
        platforms = self.ghc.meta.platforms;
      };
    })
  ));

  hspec = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
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
      buildDepends = [ (pkgs.lib.getAttrFromPath [ghcVer system] hspecDiscover) ];
      testDepends = with haskellPackages; [ QuickCheck ];
      meta = {
        homepage = "http://hspec.github.com/";
        description = "A Testing Framework for Haskell";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
        maintainers = [simon peti];
      };
    })
  ));

  hspecDiscoverIntegrationTest = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
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

  hspecDiscoverExample = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
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
