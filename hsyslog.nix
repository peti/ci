/* Build instructions for the continuous integration system Hydra. */

{ hsyslogSrc ? { outPath = ../hsyslog; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
in
{
  hsyslog = genAttrs ["ghc6104" "ghc6123" "ghc704" "ghc742" "ghc763" "ghcHEAD"] (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "hsyslog";
      src = hsyslogSrc;
      version = hsyslogSrc.gitTag;
      meta = {
        homepage = "http://github.com/peti/hsyslog";
        description = "FFI interface to syslog(3) from POSIX.1-2001.";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
      };
    })));
}
