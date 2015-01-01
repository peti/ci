/* Build instructions for the continuous integration system Hydra. */

{ hledgerSrc ? { outPath = ../hledger; revCount = 0; gitTag = "dirty"; }
, hledgerInterestSrc ? { outPath = ./.; revCount = 0; gitTag = "dirty"; }
, hledgerIrrSrc ? { outPath = ../hledger-irr; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc763" "ghc784"]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;

  peti = "Peter Simons <simons@cryp.to>";
  simon = "Simon Michael <simon@joyful.com>";
  joachim = "Joachim Breitner <mail@joachim-breitner.de>";
in
rec {
  hledgerLib = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hledger-lib";
      src = hledgerSrc;
      version = hledgerSrc.gitTag;
      postUnpack = "sourceRoot+=/hledger-lib";
      buildDepends = with haskellPackages; [
        cmdargs csv filepath HUnit mtl parsec prettyShow regexCompatTdfa
        regexpr safe split time transformers utf8String testFramework
        testFrameworkHunit dataPprint Decimal blazeMarkup
      ];
      meta.maintainers = [simon peti];
    })));

  hledger = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      myHledgerLib = pkgs.lib.getAttrFromPath [ghcVer system] hledgerLib;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hledger";
      src = hledgerSrc;
      version = hledgerSrc.gitTag;
      postUnpack = "sourceRoot+=/hledger";
      buildDepends = with haskellPackages; [ myHledgerLib haskeline shakespeareText tabular wizards ];
      noHaddock = self.ghc.ghc.version == "7.2.2";
      meta.maintainers = [simon peti];
    })));

  hledgerWeb = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      myHledgerLib = pkgs.lib.getAttrFromPath [ghcVer system] hledgerLib;
      myHledger = pkgs.lib.getAttrFromPath [ghcVer system] hledger;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hledger-web";
      src = hledgerSrc;
      version = hledgerSrc.gitTag;
      postUnpack = "sourceRoot+=/hledger-web";
      buildDepends = with haskellPackages; [
        blazeHtml blazeMarkup clientsession cmdargs dataDefault filepath
        hamlet hjsmin myHledger myHledgerLib httpClient httpConduit HUnit json
        networkConduit parsec regexpr safe shakespeareText text time
        transformers wai waiExtra waiHandlerLaunch warp yaml yesod
        yesodCore yesodStatic
      ];
      testDepends = with haskellPackages; [ hspec yesod yesodTest ];
      meta.maintainers = [simon peti];
    })));

  hledgerInterest = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      myHledgerLib = pkgs.lib.getAttrFromPath [ghcVer system] hledgerLib;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hledger-interest";
      src = hledgerInterestSrc;
      version = hledgerInterestSrc.gitTag;
      buildDepends = with haskellPackages; [ myHledgerLib mtl ];
      meta.maintainers = [peti];
    })));

  /* Disabled: there seems no point in running those builds because
     errors reported by Hydra don't get fixed anyway.

  hledgerIrr = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      myHledgerLib = pkgs.lib.getAttrFromPath [ghcVer system] hledgerLib;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hledger-irr";
      src = hledgerIrrSrc;
      version = hledgerInterestSrc.gitTag;
      preConfigure = "$SHELL hledger-irr.cabal.sh";
      buildDepends = with haskellPackages; [ myHledgerLib time Cabal statistics ];
      meta.maintainers = [joachim peti];
    })));
   */
}
