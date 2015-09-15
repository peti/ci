/* Verify Stackage package sets in Nixpkgs. */

{ buildDarwin ? false
, supportedSystems ? ["x86_64-linux"] ++ (if buildDarwin then ["x86_64-darwin"] else [])
}:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; allowTexliveBuilds = true; });

let

  all = [ "lts-0_0" "lts-0_1" "lts-0_2" "lts-0_3" "lts-0_4" "lts-0_5" "lts-0_6"
          "lts-0_7" "lts-1_0" "lts-1_1" "lts-1_2" "lts-1_4" "lts-1_5" "lts-1_7"
          "lts-1_8" "lts-1_9" "lts-1_10" "lts-1_11" "lts-1_12" "lts-1_13" "lts-1_14"
          "lts-1_15" "lts-2_0" "lts-2_1" "lts-2_2" "lts-2_3" "lts-2_4" "lts-2_5"
          "lts-2_6" "lts-2_7" "lts-2_8" "lts-2_9" "lts-2_10" "lts-2_11" "lts-2_12"
          "lts-2_13" "lts-2_14" "lts-2_15" "lts-2_16" "lts-2_17" "lts-2_18"
          "lts-2_19" "lts-2_20" "lts-2_21" "lts-2_22" "lts-3_0" "lts-3_1" "lts-3_2"
          "lts-3_3" "lts-3_4" "lts-3_5"
        ];

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

  # haskell.packages.lts-0_0 = packagePlatforms pkgs.haskell.packages.lts-0_0;
  # haskell.packages.lts-0_1 = packagePlatforms pkgs.haskell.packages.lts-0_1;
  # haskell.packages.lts-0_2 = packagePlatforms pkgs.haskell.packages.lts-0_2;
  # haskell.packages.lts-0_3 = packagePlatforms pkgs.haskell.packages.lts-0_3;
  # haskell.packages.lts-0_4 = packagePlatforms pkgs.haskell.packages.lts-0_4;
  # haskell.packages.lts-0_5 = packagePlatforms pkgs.haskell.packages.lts-0_5;
  # haskell.packages.lts-0_6 = packagePlatforms pkgs.haskell.packages.lts-0_6;
  haskell.packages.lts-0_7 = packagePlatforms pkgs.haskell.packages.lts-0_7;
  # haskell.packages.lts-1_0 = packagePlatforms pkgs.haskell.packages.lts-1_0;
  # haskell.packages.lts-1_1 = packagePlatforms pkgs.haskell.packages.lts-1_1;
  # haskell.packages.lts-1_2 = packagePlatforms pkgs.haskell.packages.lts-1_2;
  # haskell.packages.lts-1_4 = packagePlatforms pkgs.haskell.packages.lts-1_4;
  # haskell.packages.lts-1_5 = packagePlatforms pkgs.haskell.packages.lts-1_5;
  # haskell.packages.lts-1_7 = packagePlatforms pkgs.haskell.packages.lts-1_7;
  # haskell.packages.lts-1_8 = packagePlatforms pkgs.haskell.packages.lts-1_8;
  # haskell.packages.lts-1_9 = packagePlatforms pkgs.haskell.packages.lts-1_9;
  # haskell.packages.lts-1_10 = packagePlatforms pkgs.haskell.packages.lts-1_10;
  # haskell.packages.lts-1_11 = packagePlatforms pkgs.haskell.packages.lts-1_11;
  # haskell.packages.lts-1_12 = packagePlatforms pkgs.haskell.packages.lts-1_12;
  # haskell.packages.lts-1_13 = packagePlatforms pkgs.haskell.packages.lts-1_13;
  # haskell.packages.lts-1_14 = packagePlatforms pkgs.haskell.packages.lts-1_14;
  haskell.packages.lts-1_15 = packagePlatforms pkgs.haskell.packages.lts-1_15;
  # haskell.packages.lts-2_0 = packagePlatforms pkgs.haskell.packages.lts-2_0;
  # haskell.packages.lts-2_1 = packagePlatforms pkgs.haskell.packages.lts-2_1;
  # haskell.packages.lts-2_2 = packagePlatforms pkgs.haskell.packages.lts-2_2;
  # haskell.packages.lts-2_3 = packagePlatforms pkgs.haskell.packages.lts-2_3;
  # haskell.packages.lts-2_4 = packagePlatforms pkgs.haskell.packages.lts-2_4;
  # haskell.packages.lts-2_5 = packagePlatforms pkgs.haskell.packages.lts-2_5;
  # haskell.packages.lts-2_6 = packagePlatforms pkgs.haskell.packages.lts-2_6;
  # haskell.packages.lts-2_7 = packagePlatforms pkgs.haskell.packages.lts-2_7;
  # haskell.packages.lts-2_8 = packagePlatforms pkgs.haskell.packages.lts-2_8;
  # haskell.packages.lts-2_9 = packagePlatforms pkgs.haskell.packages.lts-2_9;
  # haskell.packages.lts-2_10 = packagePlatforms pkgs.haskell.packages.lts-2_10;
  # haskell.packages.lts-2_11 = packagePlatforms pkgs.haskell.packages.lts-2_11;
  # haskell.packages.lts-2_12 = packagePlatforms pkgs.haskell.packages.lts-2_12;
  # haskell.packages.lts-2_13 = packagePlatforms pkgs.haskell.packages.lts-2_13;
  # haskell.packages.lts-2_14 = packagePlatforms pkgs.haskell.packages.lts-2_14;
  # haskell.packages.lts-2_15 = packagePlatforms pkgs.haskell.packages.lts-2_15;
  # haskell.packages.lts-2_16 = packagePlatforms pkgs.haskell.packages.lts-2_16;
  # haskell.packages.lts-2_17 = packagePlatforms pkgs.haskell.packages.lts-2_17;
  # haskell.packages.lts-2_18 = packagePlatforms pkgs.haskell.packages.lts-2_18;
  # haskell.packages.lts-2_19 = packagePlatforms pkgs.haskell.packages.lts-2_19;
  # haskell.packages.lts-2_20 = packagePlatforms pkgs.haskell.packages.lts-2_20;
  # haskell.packages.lts-2_21 = packagePlatforms pkgs.haskell.packages.lts-2_21;
  haskell.packages.lts-2_22 = packagePlatforms pkgs.haskell.packages.lts-2_22;
  # haskell.packages.lts-3_0 = packagePlatforms pkgs.haskell.packages.lts-3_0;
  # haskell.packages.lts-3_1 = packagePlatforms pkgs.haskell.packages.lts-3_1;
  # haskell.packages.lts-3_2 = packagePlatforms pkgs.haskell.packages.lts-3_2;
  # haskell.packages.lts-3_3 = packagePlatforms pkgs.haskell.packages.lts-3_3;
  # haskell.packages.lts-3_4 = packagePlatforms pkgs.haskell.packages.lts-3_4;
  haskell.packages.lts-3_5 = packagePlatforms pkgs.haskell.packages.lts-3_5;

}
// mapHaskellTestOn {

  mtl = all;

}
