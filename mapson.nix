/* Build instructions for the continuous integration system Hydra. */

{ mapsonSrc ? { outPath = ../mapson; revCount = 0; gitTag = "dirty"; }
}:

let
  pkgs = import <nixpkgs> { };
  version = mapsonSrc.gitTag;
  versionSuffix = "";
in
rec {

  tarball = pkgs.releaseTools.sourceTarball {
    name = "mapson-tarball";
    src = mapsonSrc;
    inherit version versionSuffix;
    buildInputs = with pkgs; [
      git perl asciidoc libxml2 asciidoc texinfo xmlto docbook2x
      docbook_xsl docbook_xml_dtd_45 libxslt
    ];
    postUnpack = ''
      cp -r ${pkgs.gnulib}/ gnulib/
      chmod -R u+w gnulib
      patchShebangs gnulib
      ln -s ../gnulib $sourceRoot/gnulib
    '';
    configureFlags = [
      "--with-mailboxdir=/var/spool/mail"
      "--with-mta=/var/setuid-wrappers/sendmail"
    ];
    distPhase = ''
      make distcheck AM_DISTCHECK_CONFIGURE_FLAGS="$configureFlags"
      mkdir $out/tarballs
      mv -v mapson-*.tar* $out/tarballs/
    '';
  };

  build = pkgs.lib.genAttrs [ "x86_64-linux" ] (system:
    let pkgs = import <nixpkgs> { inherit system; }; in
    pkgs.releaseTools.nixBuild {
      name = "mapson";
      src = tarball;
      buildInputs = with pkgs; [ flex bison ];
      configureFlags = [
        "--with-mailboxdir=/var/spool/mail"
        "--with-mta=/var/setuid-wrappers/sendmail"
      ];
    });
}
