/* Build instructions for the continuous integration system Hydra. */

{ petidomoSrc ? { outPath = ../petidomo; revCount = 0; gitTag = "dirty"; }
}:

let
  pkgs = import <nixpkgs> { };
  version = petidomoSrc.gitTag;
  versionSuffix = "";
  texLiveEnv = pkgs.texlive.combine { inherit (pkgs.texlive) scheme-medium lastpage tex4ht; };
in
rec {

  tarball = pkgs.releaseTools.sourceTarball {
    name = "petidomo-tarball";
    src = petidomoSrc;
    inherit version versionSuffix;
    buildInputs = with pkgs; [ git perl flex bison texLiveEnv ];
    postUnpack = ''
      cp -r ${pkgs.gnulib}/ gnulib/
      chmod -R u+w gnulib
      patchShebangs gnulib
      ln -s ../gnulib $sourceRoot/gnulib
    '';
    configureFlags = "--with-mta=/var/setuid-wrappers/sendmail";
    distPhase = ''
      make distcheck AM_DISTCHECK_CONFIGURE_FLAGS="$configureFlags"
      mkdir $out/tarballs
      mv -v petidomo-*.tar* $out/tarballs/
    '';
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" ] (system:
    let pkgs = import <nixpkgs> { inherit system; }; in
    pkgs.releaseTools.nixBuild {
      name = "petidomo";
      src = tarball;
      buildInputs = with pkgs; [ flex bison ];
      configureFlags = "--with-mta=/var/setuid-wrappers/sendmail";
    });
}
