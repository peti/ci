{ mkDerivation, base, fetchgit, filepath, process, stdenv }:
mkDerivation {
  pname = "funcmp";
  version = "1.9";
  src = fetchgit {
    url = "http://git.savannah.gnu.org/r/funcmp.git";
    sha256 = "9678761c4263b74072618ce546a862a3c83c874646081820585b785a1c171851";
    rev = "56ff421e02330a33f9577789dd7d631060b83b8d";
  };
  buildDepends = [ base filepath process ];
  homepage = "http://savannah.nongnu.org/projects/funcmp/";
  description = "Functional MetaPost";
  license = stdenv.lib.licenses.gpl3;
}
