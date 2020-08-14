/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

let
  releaseTools = import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };

  inherit (releaseTools) pkgs supportedMatches mapTestOn packagePlatforms;

  pkgsFor = releaseTools.mkPkgsFor null;

  ghc865  = "ghc865";
  ghc884  = "ghc884";
  ghc8102 = "ghc8102";
  ghcHEAD = "ghcHEAD";
  default = [ ghc884 ];
  all     = [ ghc865 ghc884 ghc8102 /*ghcHEAD*/ ];

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
  haskell-ci = supportedSystems;
  hlint = supportedSystems;
  hugs = supportedSystems;
  pandoc = supportedSystems;
  shellcheck = supportedSystems;
  stack = supportedSystems;
  stylish-cabal = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;

} // mapHaskellTestOn {

  Cabal_3_2_0_0 = all;
  policeman = default;
  cabal-install = [ghc884 ghc8102];
  cabal-plan = default;
  distribution-nixpkgs = [ghc884 ghc8102];
  funcmp = all;
  git-annex = [ghc884 ghc8102];
  hackage-db = [ghc884 ghc8102];
  hledger = [ghc884 ghc8102];
  hledger-ui = [ghc884 ghc8102];
  hoogle = all;
  hopenssl = [ghc884 ghc8102];
  hsdns = all;
  hsemail = [ghc884 ghc8102];
  hsyslog = [ghc884 ghc8102];
  jailbreak-cabal = all;
  language-nix = all;
  nix-paths = all;
  pandoc = [ghc884 ghc8102];
  stack = [ghc884 ghc8102];
  titlecase = all;
  xmonad = [ghc884 ghc8102];
  xmonad-contrib = [ghc884 ghc8102];

}
