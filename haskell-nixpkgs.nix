/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

let
  releaseTools = import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };

  inherit (releaseTools) pkgs supportedMatches mapTestOn packagePlatforms;

  pkgsFor = releaseTools.mkPkgsFor null;

  ghc865  = "ghc865";
  ghc884  = "ghc884";
  ghc8102 = "ghc8102";
  ghc901  = "ghc901";
  ghcHEAD = "ghcHEAD";
  default = [ ghc8102 ];
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

  cabal-install = all;
  cabal-plan = default;
  Cabal_3_2_1_0 = [ghc865 ghc884 ghc8102];
  distribution-nixpkgs = default;
  funcmp = all;
  git-annex = default;
  hackage-db = default;
  haskell-language-server = all;
  hledger = default;
  hledger-ui = default;
  hoogle = all;
  hopenssl = default;
  hsdns = all;
  hsemail = default;
  hsyslog = default;
  jailbreak-cabal = all;
  language-nix = all;
  liquidhaskell = default;
  nix-paths = all;
  pandoc = default;
  policeman = default;
  stack = default;
  titlecase = all;
  xmonad = default;
  xmonad-contrib = default;

}
