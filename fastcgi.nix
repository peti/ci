/* Build instructions for the continuous integration system Hydra. */

{ fastcgiSrc ? { outPath = ../fastcgi; revCount = 0; gitTag = "dirty"; }
}:

let
  pkgs = import <nixpkgs> { };
  version = fastcgiSrc.gitTag;
  versionSuffix = "";
in
rec {

  tarball = pkgs.releaseTools.sourceTarball {
    name = "fastcgi-tarball";
    src = fastcgiSrc;
    inherit version versionSuffix;
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" ] (system:
    let pkgs = import <nixpkgs> { inherit system; }; in
    pkgs.releaseTools.nixBuild {
      name = "fastcgi";
      src = tarball;
      buildInputs = [ pkgs.boostHeaders ];
      meta.schedulingPriority = "200";  # build this package with a high priority
    });
}
