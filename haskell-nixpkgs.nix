/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc7103 = "ghc7103";
  ghc802  = "ghc802";
  ghc822  = "ghc822";
  ghc841  = "ghc841";
  ghcHEAD = "ghcHEAD";
  default = [ ghc822 ];
  all     = [ /*ghc7103*/ ghc802 ghc822 ghc841 /*ghcHEAD*/ ];

  allBut = platforms: pkgs.lib.filter (x: !(pkgs.lib.elem x platforms)) all;

  filterSupportedSystems = systems: pkgs.lib.filter (x: pkgs.lib.elem x supportedSystems) systems;

  mapHaskellTestOn = attrs: pkgs.lib.mapAttrs mkJobs attrs;

  mkJobs = pkg: ghcs: builtins.listToAttrs (pkgs.lib.concatMap (ghc: mkJob ghc pkg) ghcs);

  mkJob = ghc: pkg:
    let
      pkgPath = ["haskell" "packages" ghc pkg];
      systems = filterSupportedSystems (pkgs.lib.attrByPath (pkgPath ++ ["meta" "platforms"]) [] pkgs);
    in
      map (system: mkSystemJob system ghc pkg) systems;

  mkSystemJob = system: ghc: pkg:
    pkgs.lib.nameValuePair "${ghc}" (pkgs.lib.setAttrByPath [system] ((pkgs.lib.getAttrFromPath ["haskell" "packages" ghc pkg] (pkgsFor system))));

in

mapTestOn {

  cabal-install = supportedSystems;
  cabal2nix = supportedSystems;
  cryptol = supportedSystems;
  darcs = supportedSystems;
  emacsPackages.haskellMode = supportedSystems;
  gitAndTools.git-annex = supportedSystems;
  hugs = supportedSystems;
  multi-ghc-travis = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;

} // mapHaskellTestOn {

  distribution-nixpkgs = default;
  funcmp = all;
  git-annex = default ++ [ghc841];
  hackage-db = all;
  hledger = default ++ [ghc841];
  hledger-ui = default ++ [ghc841];
  hopenssl = default;
  hsdns = all;
  hsemail = default;
  hsyslog = default;
  jailbreak-cabal = all;
  language-nix = all;
  nix-paths = all;
  pandoc = default ++ [ghc841];
  stack = default ++ [ghc841];
  titlecase = all;

}
