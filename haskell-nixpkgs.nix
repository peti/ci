/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

let
  releaseTools = import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };

  inherit (releaseTools) pkgs supportedMatches mapTestOn packagePlatforms;

  pkgsFor = releaseTools.mkPkgsFor null;

  ghc844  = "ghc844";
  ghc865  = "ghc865";
  ghc882  = "ghc882";
  ghc8101 = "ghc8101";
  ghcHEAD = "ghcHEAD";
  default = [ ghc882 ];
  all     = [ ghc844 ghc865 ghc882 ghc8101 /*ghcHEAD*/ ];

  allBut = platforms: pkgs.lib.filter (x: !(pkgs.lib.elem x platforms)) all;

  filterSupportedSystems = systems: pkgs.lib.filter (x: pkgs.lib.elem x supportedSystems) systems;

  mapHaskellTestOn = attrs: pkgs.lib.mapAttrs mkJobs attrs;

  mkJobs = pkg: ghcs: builtins.listToAttrs (pkgs.lib.concatMap (ghc: mkJob ghc pkg) ghcs);

  mkJob = ghc: pkg: map (system: mkSystemJob system ghc pkg)
                        (supportedMatches pkgs.haskell.packages.${ghc}.${pkg}.meta.platforms);

  mkSystemJob = system: ghc: pkg:
    pkgs.lib.nameValuePair "${ghc}" (pkgs.lib.setAttrByPath [system] ((pkgs.lib.getAttrFromPath ["haskell" "packages" ghc pkg] (pkgsFor system))));

in

mapTestOn {

  cabal-install = supportedSystems;
  cabal2nix = supportedSystems;
  darcs = supportedSystems;
  gitAndTools.git-annex = supportedSystems;
  # haskell-ci = supportedSystems;
  hlint = supportedSystems;
  hugs = supportedSystems;
  pandoc = supportedSystems;
  stack = supportedSystems;
  stylish-cabal = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;

} // mapHaskellTestOn {

  Cabal_3_0_0_0 = all;
  policeman = default;
  cabal-install = [ghc882 ghc8101];
  cabal-plan = default;
  distribution-nixpkgs = [ghc882 ghc8101];
  funcmp = all;
  # git-annex = [ghc882 ghc8101];
  hackage-db = [ghc882 ghc8101];
  hledger = [ghc882 ghc8101];
  hledger-ui = [ghc882 ghc8101];
  hoogle = all;
  hopenssl = [ghc882 ghc8101];
  hsdns = all;
  hsemail = [ghc882 ghc8101];
  hsyslog = [ghc882 ghc8101];
  jailbreak-cabal = all;
  language-nix = all;
  nix-paths = all;
  pandoc = [ghc882 ghc8101];
  # stack = [ghc882 ghc8101];
  titlecase = all;
  xmonad = [ghc882 ghc8101];
  xmonad-contrib = [ghc882 ghc8101];

}
