/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? [ "x86_64-linux" ] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

mapTestOn {

  # cryptol2 = supportedSystems;
  # darcs = supportedSystems;
  # gitAndTools.gitAnnex = supportedSystems;
  # jhc = supportedSystems;

  ghc6101Binary = supportedSystems;
  ghc6102inary = supportedSystems;
  ghc6121Binary = supportedSystems;
  ghc642Binary = supportedSystems;
  ghc704Binary = supportedSystems;
  ghc742Binary = supportedSystems;

  ghc6101 = supportedSystems;
  ghc6102 = supportedSystems;
  ghc6103 = supportedSystems;
  ghc6104 = supportedSystems;
  # ghc611 = supportedSystems;
  ghc6121 = supportedSystems;
  ghc6122 = supportedSystems;
  ghc6123 = supportedSystems;
  ghc642 = supportedSystems;
  # ghc661 = supportedSystems;
  ghc682 = supportedSystems;
  # ghc683 = supportedSystems;
  ghc701 = supportedSystems;
  ghc702 = supportedSystems;
  ghc703 = supportedSystems;
  ghc704 = supportedSystems;
  ghc721 = supportedSystems;
  ghc722 = supportedSystems;
  ghc741 = supportedSystems;
  ghc742 = supportedSystems;
  ghc761 = supportedSystems;
  ghc762 = supportedSystems;
  ghc763 = supportedSystems;
  ghc783 = supportedSystems;
  ghcHEAD = supportedSystems;
  ghc = supportedSystems;

  haskellPackages = packagesWithMetaPlatform pkgs.haskellPackages;

}
