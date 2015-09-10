{ mkDerivation, base, containers, doctest, fetchgit, hspec, HUnit
, mtl, parsec, QuickCheck, stdenv, transformers
, transformers-compat
}:
mkDerivation {
  pname = "language-nix";
  version = "1.0.1";
  src = fetchgit {
    url = "git://github.com/peti/language-nix.git";
    sha256 = "d410efa889272956e6595cc0eb37792df2a197724562224f11e846916a02e9bd";
    rev = "e0641777d1e7292429c5c152e8370d2b2dab919b";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers mtl parsec QuickCheck transformers
    transformers-compat
  ];
  executableHaskellDepends = [
    base containers mtl parsec QuickCheck transformers
    transformers-compat
  ];
  testHaskellDepends = [
    base containers doctest hspec HUnit mtl parsec QuickCheck
    transformers transformers-compat
  ];
  homepage = "https://github.com/peti/language-nix";
  description = "Data types and useful functions to represent and manipulate the Nix language";
  license = stdenv.lib.licenses.bsd3;
}
