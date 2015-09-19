{ mkDerivation, base, base-compat, Cabal, deepseq, doctest
, fetchgit, lens, pretty, QuickCheck, stdenv
}:
mkDerivation {
  pname = "language-nix";
  version = "2.1";
  src = fetchgit {
    url = "git://github.com/peti/language-nix.git";
    sha256 = "cd76e0a0ee952cd42ade15020516f414336811ccc60ce3f1e9672c4fab29bae4";
    rev = "77b675a02786b37611476fbb7ef29ad064f4fa3c";
  };
  libraryHaskellDepends = [
    base base-compat Cabal deepseq lens pretty QuickCheck
  ];
  testHaskellDepends = [
    base base-compat Cabal deepseq doctest lens pretty QuickCheck
  ];
  homepage = "https://github.com/peti/language-nix#readme";
  description = "Data types and useful functions to represent and manipulate the Nix language";
  license = stdenv.lib.licenses.bsd3;
}
