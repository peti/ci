/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

let
  releaseTools = import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };

  inherit (releaseTools) pkgs supportedMatches mapTestOn packagePlatforms;

  pkgsFor = releaseTools.mkPkgsFor null;

  ghc844  = "ghc844";
  ghc865  = "ghc865";
  ghc881  = "ghc881";
  ghcHEAD = "ghcHEAD";
  default = [ ghc865 ];
  all     = [ ghc844 ghc865 ghc881 /*ghcHEAD*/ ];

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
  stack = supportedSystems;
  stylish-cabal = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;

} // mapHaskellTestOn {

  base-compat = all;
  base-compat-batteries = all;
  cabal-install = [ghc881];
  distribution-nixpkgs = [ghc881];
  funcmp = all;
  git-annex = [ghc881];
  hackage-db = [ghc881];
  hledger = [ghc881];
  hledger-ui = [ghc881];
  hopenssl = [ghc881];
  hsdns = all;
  hsemail = [ghc881];
  hsyslog = [ghc881];
  jailbreak-cabal = all;
  lambdabot-core = [ghc881];
  lambdabot-irc-plugins = [ghc881];
  language-nix = all;
  nix-paths = all;
  pandoc = [ghc881];
  stack = [ghc881];
  titlecase = all;
  xmonad = [ghc881];

}
