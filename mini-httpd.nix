/* Build instructions for the continuous integration system Hydra. */

{ miniHttpdSrc ? { outPath = ../mini-httpd; revCount = 0; gitTag = "dirty"; }
}:

let
  pkgs = import <nixpkgs> { system = "x86_64-linux"; };
  version = miniHttpdSrc.gitTag;
  versionSuffix = "";
in
rec {

  tarball = pkgs.releaseTools.sourceTarball {
    name = "mini-httpd-tarball";
    src = miniHttpdSrc;
    inherit version versionSuffix;
    buildInputs = with pkgs; [
      git perl asciidoc libxml2 asciidoc texinfo xmlto docbook2x
      docbook_xsl docbook_xml_dtd_45 libxslt boostHeaders
    ];
    postUnpack = ''
      cp -r ${pkgs.gnulib}/ gnulib/
      chmod -R u+w gnulib
      patchShebangs gnulib
      ln -s ../gnulib $sourceRoot/gnulib
    '';
    distPhase = ''
      make distcheck
      mkdir $out/tarballs
      mv -v mini-httpd-*.tar* $out/tarballs/
    '';
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" ] (system:
    let pkgs = import <nixpkgs> { inherit system; }; in
    pkgs.releaseTools.nixBuild {
      name = "mini-httpd";
      src = tarball;
      buildInputs = [ pkgs.boostHeaders ];
      meta.schedulingPriority = "200";  # build this package with a high priority
    });
}
