/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? ["x86_64-linux"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc704  = "ghc704";
  ghc722  = "ghc722";
  ghc742  = "ghc742";
  ghc763  = "ghc763";
  ghc784  = "ghc784";
  ghc7103 = "ghc7103";
  ghc802  = "ghc802";
  ghc821  = "ghc821";
  ghcHEAD = "ghcHEAD";
  default = [ ghc802 ghc821 ];
  all     = [ ghc704 ghc722 ghc742 ghc763 ghc784 ghc7103 ghc802 ghc821 /*ghcHEAD*/ ];

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
  git-annex = default;
  hackage-db = all;
  hopenssl = default;
  hsdns = all;
  hsemail = all;
  hsyslog = default;
  jailbreak-cabal = all;
  language-nix = allBut [ ghc704 ghc722 ghc742 ];
  nix-paths = all;
  pandoc = default;
  stack = default;
  titlecase = allBut [ ghc704 ghc722 ghc742 ];

}
