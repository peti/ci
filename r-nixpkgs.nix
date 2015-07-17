/* Essential R packages in Nixpkgs that must build. */

{ supportedSystems ? [ "x86_64-linux" ] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; allowTexliveBuilds = true; });

mapTestOn {
  rPackages = packagePlatforms pkgs.rPackages;
}
