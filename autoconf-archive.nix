/* Build instructions for the continuous integration system Hydra. */

{ autoconfArchiveSrc ? { outPath = ../autoconf-archive; revCount = 0; gitTag = "dirty"; }
}:

let
  pkgs = import <nixpkgs> { config.allowTexliveBuilds = true; };
  version = autoconfArchiveSrc.gitTag;
  versionSuffix = "";
in
rec {

  tarball = pkgs.releaseTools.sourceTarball {
    name = "autoconf-archive-tarball";
    src = autoconfArchiveSrc;
    inherit version versionSuffix;
    dontBuild = false;
    buildInputs = with pkgs; [
      git perl texinfo5 python3 lzip htmlTidy
      (texLiveAggregationFun { paths = [ texLive texLiveCMSuper texinfo5 ]; })
    ];
    postUnpack = ''
      cp -r ${pkgs.gnulib}/ gnulib/
      chmod -R u+w gnulib
      patchShebangs gnulib
      ln -s ../gnulib $sourceRoot/gnulib
    '';
    buildPhase = ''
      make -j$NIX_BUILD_CORES PYTHON=python3 maintainer-all all
      make PYTHON=python3 web-manual && bash fix-website.sh
    '';
    distPhase = ''
      make PYTHON=python3 distcheck
      mkdir $out/tarballs
      mv -v autoconf-archive-*.tar* $out/tarballs/
    '';
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" ] (system:
    let pkgs = import <nixpkgs> { inherit system; }; in
    pkgs.releaseTools.nixBuild {
      name = "autoconf-archive";
      src = tarball;
    });

}
