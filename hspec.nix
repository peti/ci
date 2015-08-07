/* Build instructions for the continuous integration system Hydra. */

{ hspecSrc ? { outPath = ../hspec; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc704" "ghc722" "ghc742" "ghc763" "ghc784" "ghc7102" "ghcHEAD"]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;

  peti = "Peter Simons <simons@cryp.to>";
  simon = "Simon Hengel <sol@typeful.net>";
in
rec {
  hspec-core = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
    in
    haskellPackages.mkDerivation {
      pname = "hspec-core";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      postUnpack = "sourceRoot+=/hspec-core";
      buildDepends = with haskellPackages; [
        ansi-terminal async base deepseq hspec-expectations HUnit
        QuickCheck quickcheck-io random setenv tf-random time transformers
      ];
      testDepends = with haskellPackages; [
        ansi-terminal async base deepseq hspec-expectations hspec-meta
        HUnit process QuickCheck quickcheck-io random setenv silently
        tf-random time transformers
      ];
      homepage = "http://hspec.github.io/";
      description = "A Testing Framework for Haskell";
      license = pkgs.stdenv.lib.licenses.mit;
      maintainers = [simon peti];
    }));

  hspec-discover = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
    in
    haskellPackages.mkDerivation {
      pname = "hspec-discover";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      postUnpack = "sourceRoot+=/hspec-discover";
      isLibrary = true;
      isExecutable = true;
      doHaddock = false;
      buildDepends = with haskellPackages; [ base directory filepath ];
      testDepends = with haskellPackages; [ base directory filepath hspec-meta ];
      homepage = "http://hspec.github.io/";
      description = "Automatically discover and run Hspec tests";
      license = pkgs.stdenv.lib.licenses.mit;
      maintainers = [simon peti];
    }));

  hspec = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
    in
    haskellPackages.mkDerivation {
      pname = "hspec";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      buildDepends = with haskellPackages; [
        (pkgs.lib.getAttrFromPath [ghcVer system] hspec-discover)
        (pkgs.lib.getAttrFromPath [ghcVer system] hspec-core)
        base hspec-expectations HUnit QuickCheck transformers
      ];
      testDepends = with haskellPackages; [
        base directory hspec-meta stringbuilder
      ];
      homepage = "http://hspec.github.io/";
      description = "A Testing Framework for Haskell";
      license = pkgs.stdenv.lib.licenses.mit;
      maintainers = [simon peti];
    }));

  hspec-discover-integration-test = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
    in
    haskellPackages.mkDerivation {
      pname = "hspec-discover-integration-test";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      doHaddock = false;
      postUnpack = "sourceRoot+=/hspec-discover/integration-test";
      testDepends = with haskellPackages; [
        (pkgs.lib.getAttrFromPath [ghcVer system] hspec)
        base transformers
      ];
      license = "unknown";
      maintainers = [simon peti];
    }));

  hspec-discover-example = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
    in
    haskellPackages.mkDerivation {
      pname = "hspec-discover-example";
      src = hspecSrc;
      version = hspecSrc.gitTag;
      doHaddock = false;
      postUnpack = "sourceRoot+=/hspec-discover/example";
      testDepends = with haskellPackages; [
        (pkgs.lib.getAttrFromPath [ghcVer system] hspec)
        base QuickCheck
      ];
      license = "unknown";
      maintainers = [simon peti];
    }));

}
