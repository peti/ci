/* Build instructions for the continuous integration system Hydra. */

{ cabal2nixSrc ? { outPath = ../cabal2nix; revCount = 0; gitTag = "dirty"; }
, supportedPlatforms ? [ "x86_64-linux" ]
}:

let
  genAttrs = (import <nixpkgs> { }).lib.genAttrs;
in
{
  cabal2nix = genAttrs ["ghc6123" "ghc704" "ghc742" "ghc763"] (ghcVer: genAttrs supportedPlatforms (system:
    let
      pkgs = import <nixpkgs> { inherit system; };
      haskellPackages = pkgs.lib.getAttrFromPath ["haskellPackages_${ghcVer}"] pkgs;
    in
    haskellPackages.cabal.mkDerivation (self: {
      pname = "cabal2nix";
      src = cabal2nixSrc;
      version = cabal2nixSrc.gitTag;
      isLibrary = false;
      isExecutable = true;
      buildDepends = with haskellPackages; [ Cabal filepath hackageDb HTTP mtl regexPosix ];
      testDepends = with haskellPackages; [ doctest ];
      meta = {
        homepage = "http://github.com/NixOS/cabal2nix";
        description = "Convert Cabal files into Nix build instructions";
        license = self.stdenv.lib.licenses.bsd3;
        platforms = self.ghc.meta.platforms;
        maintainers = [ self.stdenv.lib.maintainers.simons ];
        schedulingPriority = "200";  # build this package with a high priority
      };
    })));
}
