/* Build instructions for the continuous integration system Hydra. */

{ hsyslogSrc ? { outPath = ../hsyslog; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc6104" "ghc6123" "ghc704" "ghc722" "ghc742" "ghc763" "ghc784" /*"ghcHEAD"*/]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
in
{
  hsyslog = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
      Cabal = if pkgs.lib.versionOlder haskellPackages.ghc.version "7" then haskellPackages.Cabal_1_16_0_3 else null;
      cabal = haskellPackages.cabal.override { inherit Cabal; };
    in
    cabal.mkDerivation (self: {
      pname = "hsyslog";
      src = hsyslogSrc;
      version = hsyslogSrc.gitTag;
      testDepends = with haskellPackages; [doctest];
      noHaddock = pkgs.lib.versionOlder haskellPackages.ghc.version "7";
      meta = {
        homepage = "http://github.com/peti/hsyslog";
        description = "FFI interface to syslog(3) from POSIX.1-2001.";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
      };
    })));
}
