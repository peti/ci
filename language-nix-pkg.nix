{ mkDerivation, base, containers, doctest, fetchgit, hspec, HUnit
, mtl, parsec, QuickCheck, stdenv, transformers
}:
mkDerivation {
  pname = "language-nix";
  version = "1.0";
  src = fetchgit {
    url = "git://github.com/peti/language-nix.git";
    sha256 = "322645314fd0b8bc3966408748157775d195cb01884657ab4f1ffe352060e3d8";
    rev = "e1a469b901584f9cc466da16bb00d77d35b69650";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers mtl parsec QuickCheck transformers
  ];
  executableHaskellDepends = [
    base containers mtl parsec QuickCheck transformers
  ];
  testHaskellDepends = [
    base containers doctest hspec HUnit mtl parsec QuickCheck
    transformers
  ];
  homepage = "https://github.com/peti/language-nix";
  description = "Haskell AST and Parsers for the Nix language";
  license = stdenv.lib.licenses.bsd3;
}
