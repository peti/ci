/* Essential Haskell packages in Nixpkgs that must build. */

{ buildAllNGPackages ? false
, buildDarwin ? false
, supportedSystems ? ["x86_64-linux"] ++ (if buildDarwin then ["x86_64-darwin"] else [])
}:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc704  = "ghc704";
  ghc722  = "ghc722";
  ghc742  = "ghc742";
  ghc763  = "ghc763";
  ghc784  = "ghc784";
  ghc7103 = "ghc7103";
  ghc801  = "ghc801";
  ghcHEAD = "ghcHEAD";
  default = [ ghc7103 ];
  all     = [ ghc704 ghc722 ghc742 ghc763 ghc784 ghc7103 ghc801 /*ghcHEAD*/ ];

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

pkgs.lib.optionalAttrs buildAllNGPackages (mapTestOn {

  cryptol = supportedSystems;
  darcs = supportedSystems;
  emacsPackages.haskellMode = supportedSystems;
  gitAndTools.git-annex = supportedSystems;
  hugs = supportedSystems;
  pandoc = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;
  # haskell.packages.lts-4_2 = packagePlatforms pkgs.haskell.packages.lts-4_2;

})
// mapHaskellTestOn {

  funcmp = all;
  hackage-db = all;
  hopenssl = all;
  hsdns = all;
  hsemail = all;
  hsyslog = all;
  jailbreak-cabal = all;

}
