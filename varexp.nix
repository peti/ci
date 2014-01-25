/* Build instructions for the continuous integration system Hydra. */

{ varexpSrc ? { outPath = ../varexp; revCount = 0; gitTag = "dirty"; }
}:

let
  pkgs = import <nixpkgs> { };
  version = varexpSrc.gitTag;
  versionSuffix = "";
in
rec {

  tarball = pkgs.releaseTools.sourceTarball {
    name = "varexp-tarball";
    src = varexpSrc;
    inherit version versionSuffix;
    buildInputs = with pkgs; [ git perl xmlto libxml2 docbook_xml_dtd_45 ];
    postUnpack = ''
      cp -r ${pkgs.gnulib}/ gnulib/
      chmod -R u+w gnulib
      patchShebangs gnulib
      ln -s ../gnulib $sourceRoot/gnulib
    '';
    distPhase = ''
      make distcheck
      mkdir $out/tarballs
      mv -v varexp-*.tar* $out/tarballs/
    '';
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" ] (system:
    let pkgs = import <nixpkgs> { inherit system; }; in
    pkgs.releaseTools.nixBuild {
      name = "varexp";
      src = tarball;
    });
}
