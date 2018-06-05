/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc7103 = "ghc7103";
  ghc802  = "ghc802";
  ghc822  = "ghc822";
  ghc843  = "ghc843";
  ghcHEAD = "ghcHEAD";
  default = [ ghc822 ];
  all     = [ /*ghc7103*/ ghc802 ghc822 ghc843 /*ghcHEAD*/ ];

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

  distribution-nixpkgs = default;
  funcmp = all;
  git-annex = default ++ [ghc843];
  hackage-db = all;
  hledger = default ++ [ghc843];
  hledger-ui = default ++ [ghc843];
  hopenssl = default;
  hsdns = all;
  hsemail = default;
  hsyslog = default;
  jailbreak-cabal = all;
  lambdabot-core = default ++ [ghc843];
  lambdabot-irc-plugins = default ++ [ghc843];
  language-nix = all;
  nix-paths = all;
  pandoc = default ++ [ghc843];
  stack = default ++ [ghc843];
  titlecase = all;
  xmonad = default ++ [ghc843];

}
