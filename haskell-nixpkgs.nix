/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

let
  releaseTools = import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };

  inherit (releaseTools) pkgs supportedMatches mapTestOn packagePlatforms;

  pkgsFor = releaseTools.mkPkgsFor null;

  ghc865  = "ghc865";
  ghc884  = "ghc884";
  ghc8102 = "ghc8102";
  ghc901 = "ghc901";
  ghcHEAD = "ghcHEAD";
  default = [ ghc884 ];
  all     = [ ghc865 ghc884 ghc8102 ghc901 ];

  allBut = platforms: pkgs.lib.filter (x: !(pkgs.lib.elem x platforms)) all;

  filterSupportedSystems = systems: pkgs.lib.filter (x: pkgs.lib.elem x supportedSystems) systems;

  mapHaskellTestOn = attrs: pkgs.lib.mapAttrs mkJobs attrs;

  mkJobs = pkg: ghcs: builtins.listToAttrs (pkgs.lib.concatMap (ghc: mkJob ghc pkg) ghcs);

  mkJob = ghc: pkg: map (system: mkSystemJob system ghc pkg)
                        (supportedMatches pkgs.haskell.packages.${ghc}.${pkg}.meta.platforms);

  mkSystemJob = system: ghc: pkg:
    pkgs.lib.nameValuePair "${ghc}" (pkgs.lib.setAttrByPath [system] ((pkgs.lib.getAttrFromPath ["haskell" "packages" ghc pkg] (pkgsFor system))));

  mkJobSet = sysPkgs: hsPkgs: pkgs.lib.recursiveUpdate (mapTestOn sysPkgs) (mapHaskellTestOn hsPkgs);

in

mkJobSet {

  cabal-install = supportedSystems;
  cabal2nix = supportedSystems;
  darcs = supportedSystems;
  gitAndTools.git-annex = supportedSystems;
  hlint = supportedSystems;
  hugs = supportedSystems;
  pandoc = supportedSystems;
  shellcheck = supportedSystems;
  stack = supportedSystems;
  stylish-cabal = supportedSystems;
  haskell-language-server = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;

} {

  cabal-install = [ghc884 ghc8102 ghc901];
  cabal-plan = default;
  Cabal_3_2_0_0 = all;
  distribution-nixpkgs = [ghc884 ghc8102];
  funcmp = all;
  git-annex = [ghc884 ghc8102];
  hackage-db = [ghc884 ghc8102];
  haskell-language-server = all;
  hledger = [ghc884 ghc8102];
  hledger-ui = [ghc884 ghc8102];
  hoogle = all;
  hopenssl = [ghc884 ghc8102];
  hsdns = all;
  hsemail = [ghc884 ghc8102];
  hsyslog = [ghc884 ghc8102];
  jailbreak-cabal = all;
  language-nix = all;
  liquidhaskell = [ghc8102];
  nix-paths = all;
  pandoc = [ghc884 ghc8102];
  policeman = default;
  stack = default;
  titlecase = all;
  xmonad = [ghc884 ghc8102];
  xmonad-contrib = [ghc884 ghc8102];

}
