/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc822  = "ghc822";
  ghc844  = "ghc844";
  ghc861  = "ghc861";
  ghcHEAD = "ghcHEAD";
  default = [ ghc844 ];
  all     = [ ghc822 ghc844 ghc861 /*ghcHEAD*/ ];

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
  hackage-db = default ++ [ ghc861 ];
  hledger = default ++ [ ghc861 ];
  hledger-ui = default ++ [ ghc861 ];
  hopenssl = default ++ [ ghc861 ];
  hsdns = all;
  hsemail = default ++ [ ghc861 ];
  hsyslog = default ++ [ ghc861 ];
  jailbreak-cabal = all;
  lambdabot-core = default ++ [ ghc861 ];
  lambdabot-irc-plugins = default ++ [ ghc861 ];
  language-nix = all;
  nix-paths = all;
  pandoc = default ++ [ ghc861 ];
  stack = default ++ [ ghc861 ];
  titlecase = all;
  xmonad = default ++ [ ghc861 ];

}
