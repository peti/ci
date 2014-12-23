/* Build instructions for the continuous integration system Hydra. */

{ shakeSrc ? { outPath = ../shake; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
, supportedCompilers ? ["ghc722" "ghc742" "ghc763" "ghc784"]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
in
{
  shake = genAttrs supportedCompilers (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "shake";
      src = shakeSrc;
      version = shakeSrc.gitTag;
      isLibrary = true;
      isExecutable = true;
      buildDepends = with haskellPackages; [
        binary deepseq extra filepath hashable random time transformers
        unorderedContainers utf8String jsFlot jsJquery
      ];
      testDepends = with haskellPackages; [
        binary deepseq extra filepath hashable QuickCheck random time
        transformers unorderedContainers utf8String
      ];
      preCheck = "testTarget=--show-details=always"; # --show-details=streaming for cabal 1.20+
      meta = {
        homepage = "https://github.com/ndmitchell/shake";
        description = "Build system library, like Make, but more accurate dependencies";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
        maintainers = [
          "Neil Mitchell <ndmitchell@gmail.com>"
          "Peter Simons <simons@cryp.to>"
        ];
      };
    })));
}
