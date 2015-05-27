/* Build instructions for the continuous integration system Hydra. */

{ hledgerSrc ? { outPath = ../hledger; revCount = 0; gitTag = "dirty"; }
, hledgerInterestSrc ? { outPath = ./.; revCount = 0; gitTag = "dirty"; }
, hledgerIrrSrc ? { outPath = ../hledger-irr; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc763" "ghc784" "ghc7101"]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;

  peti = "Peter Simons <simons@cryp.to>";
  simon = "Simon Michael <simon@joyful.com>";
in
rec {

  hledger-lib = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
    in
    haskellPackages.mkDerivation {
      pname = "hledger-lib";
      src = hledgerSrc;
      version = hledgerSrc.gitTag;
      postUnpack = "sourceRoot+=/hledger-lib";
      buildDepends = with haskellPackages; [
        array base base-compat blaze-markup bytestring cmdargs containers
        csv Decimal directory filepath HUnit mtl mtl-compat old-time parsec
        pretty-show regex-tdfa regexpr safe split time transformers
        utf8-string
      ];
      testDepends = with haskellPackages; [
        array base base-compat blaze-markup cmdargs containers csv Decimal
        directory filepath HUnit mtl mtl-compat old-time parsec pretty-show
        regex-tdfa regexpr safe split test-framework test-framework-hunit
        time transformers
      ];
      homepage = "http://hledger.org";
      description = "Core data types, parsers and utilities for the hledger accounting tool";
      license = "GPL";
      maintainers = [simon peti];
    }));

  hledger = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
      my-hledger-lib = pkgs.lib.getAttrFromPath [ghcVer system] hledger-lib;
    in
    haskellPackages.mkDerivation {
      pname = "hledger";
      src = hledgerSrc;
      version = hledgerSrc.gitTag;
      postUnpack = "sourceRoot+=/hledger";
      isLibrary = true;
      isExecutable = true;
      buildDepends = with haskellPackages; [
        base base-compat cmdargs containers csv directory filepath
        haskeline my-hledger-lib HUnit mtl mtl-compat old-time parsec
        pretty-show process regex-tdfa regexpr safe shakespeare
        shakespeare-text split tabular terminfo text time utf8-string
        wizards
      ];
      testDepends = with haskellPackages; [
        base base-compat cmdargs containers csv directory filepath
        haskeline my-hledger-lib HUnit mtl mtl-compat old-time parsec
        pretty-show process regex-tdfa regexpr safe shakespeare
        shakespeare-text split tabular test-framework test-framework-hunit
        text time transformers wizards
      ];
      homepage = "http://hledger.org";
      description = "The main command-line interface for the hledger accounting tool";
      license = "GPL";
      maintainers = [simon peti];
    }));

  hledger-web = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
      my-hledger-lib = pkgs.lib.getAttrFromPath [ghcVer system] hledger-lib;
      my-hledger = pkgs.lib.getAttrFromPath [ghcVer system] hledger;
    in
    haskellPackages.mkDerivation {
      pname = "hledger-web";
      src = hledgerSrc;
      version = hledgerSrc.gitTag;
      postUnpack = "sourceRoot+=/hledger-web";
      isLibrary = true;
      isExecutable = true;
      buildDepends = with haskellPackages; [
        base base-compat blaze-html blaze-markup bytestring clientsession
        cmdargs conduit-extra data-default directory filepath hjsmin
        my-hledger my-hledger-lib http-client http-conduit HUnit json
        network-conduit parsec regexpr safe shakespeare template-haskell
        text time transformers wai wai-extra wai-handler-launch warp yaml
        yesod yesod-core yesod-form yesod-static
      ];
      testDepends = with haskellPackages; [ base base-compat hspec yesod yesod-test ];
      homepage = "http://hledger.org";
      description = "A web interface for the hledger accounting tool";
      license = "GPL";
      maintainers = [simon peti];
    }));

  hledger-interest = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskell" "packages" ghcVer] pkgs;
      my-hledger-lib = pkgs.lib.getAttrFromPath [ghcVer system] hledger-lib;
    in
    haskellPackages.mkDerivation {
      pname = "hledger-interest";
      src = hledgerInterestSrc;
      version = hledgerInterestSrc.gitTag;
      isLibrary = false;
      isExecutable = true;
      buildDepends = with haskellPackages; [ base Cabal Decimal my-hledger-lib mtl parsec time ];
      homepage = "http://github.com/peti/hledger-interest";
      description = "computes interest for a given account";
      license = pkgs.stdenv.lib.licenses.bsd3;
      maintainers = [peti];
    }));

}
