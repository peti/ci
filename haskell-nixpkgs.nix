/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc7103 = "ghc7103";
  ghc802  = "ghc802";
  ghc822  = "ghc822";
  ghc843  = "ghc843";
  ghc861  = "ghc861";
  ghcHEAD = "ghcHEAD";
  default = [ ghc843 ];
  all     = [ /*ghc7103*/ ghc802 ghc822 ghc843 ghc861 /*ghcHEAD*/ ];

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
  cryptol = supportedSystems;
  darcs = supportedSystems;
  gitAndTools.git-annex = supportedSystems;
  hugs = supportedSystems;
  multi-ghc-travis = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;

} // mapHaskellTestOn {

  base-compat = all;
  base-compat-batteries = all;
  distribution-nixpkgs = default;
  funcmp = all;
  git-annex = default;
  hackage-db = all;
  hledger = default;
  hledger-ui = default;
  hopenssl = default;
  hsdns = all;
  hsemail = default;
  hsyslog = default;
  jailbreak-cabal = all;
  lambdabot-core = default;
  lambdabot-irc-plugins = default;
  language-nix = all;
  nix-paths = all;
  pandoc = default;
  stack = default;
  titlecase = all;
  xmonad = default;

}
