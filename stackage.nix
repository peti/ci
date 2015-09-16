/* Verify Stackage package sets in Nixpkgs. */

{ buildDarwin ? false
, supportedSystems ? ["x86_64-linux"] ++ (if buildDarwin then ["x86_64-darwin"] else [])
}:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; allowTexliveBuilds = true; });

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
