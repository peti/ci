/* Build instructions for the continuous integration system Hydra. */

{ hledgerSrc ? { outPath = ../hledger; revCount = 0; gitTag = "dirty"; }
, hledgerInterestSrc ? { outPath = ./.; revCount = 0; gitTag = "dirty"; }
, hledgerIrrSrc ? { outPath = ../hledger-irr; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
}:

let
  genAttrs = (import <nixpkgs> { system = "x86_64-linux"; }).lib.genAttrs;

  peti = "Peter Simons <simons@cryp.to>";
  simon = "Simon Michael <simon@joyful.com>";
  joachim = "Joachim Breitner <mail@joachim-breitner.de>";
in
rec {
  hledgerLib = genAttrs ["ghc704" "ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
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
        testFrameworkHunit dataPprint
      ];
      meta.maintainers = [simon peti];
      meta.schedulingPriority = "200";  # build this package with a high priority
    })));

  hledger = genAttrs ["ghc704" "ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
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
      buildDepends = with haskellPackages; [ myHledgerLib haskeline shakespeareText tabular ];
      meta.maintainers = [simon peti];
      meta.schedulingPriority = "200";  # build this package with a high priority
    })));

  hledgerWeb = genAttrs ["ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
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
        hamlet hjsmin json myHledger myHledgerLib httpConduit HUnit monadControl
        networkConduit parsec regexpr safe shakespeareCss shakespeareJs
        shakespeareText text time transformers wai waiExtra warp yaml yesod
        yesodCore yesodDefault yesodForm yesodStatic blazeHtml waiHandlerLaunch
        yesodPlatform
      ];
      testDepends = with haskellPackages; [ yesodCore yesodDefault yesodTest ];
      meta.maintainers = [simon peti];
    })));

  hledgerInterest = genAttrs ["ghc704" "ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
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
      meta.schedulingPriority = "200";  # build this package with a high priority
    })));

  hledgerIrr = genAttrs ["ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
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
      meta.schedulingPriority = "200";  # build this package with a high priority
    })));
}
