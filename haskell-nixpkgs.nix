/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

let
  releaseTools = import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };

  inherit (releaseTools) pkgs supportedMatches mapTestOn packagePlatforms;

  pkgsFor = releaseTools.mkPkgsFor null;

  ghc822  = "ghc822";
  ghc844  = "ghc844";
  ghc862  = "ghc862";
  ghcHEAD = "ghcHEAD";
  default = [ ghc844 ];
  all     = [ ghc822 ghc844 ghc862 /*ghcHEAD*/ ];

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
  hugs = supportedSystems;
  pandoc = supportedSystems;
  stack = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;

} // mapHaskellTestOn {

  base-compat = all;
  base-compat-batteries = all;
  distribution-nixpkgs = default;
  funcmp = all;
  git-annex = default;
  hackage-db = default ++ [ ghc862 ];
  hledger = default ++ [ ghc862 ];
  hledger-ui = default ++ [ ghc862 ];
  hopenssl = default ++ [ ghc862 ];
  hsdns = all;
  hsemail = default ++ [ ghc862 ];
  hsyslog = default ++ [ ghc862 ];
  jailbreak-cabal = all;
  lambdabot-core = default ++ [ ghc862 ];
  lambdabot-irc-plugins = default ++ [ ghc862 ];
  language-nix = all;
  nix-paths = all;
  pandoc = default ++ [ ghc862 ];
  stack = default ++ [ ghc862 ];
  titlecase = all;
  xmonad = default ++ [ ghc862 ];

}
