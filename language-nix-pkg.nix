{ mkDerivation, base, Cabal, deepseq, doctest, fetchgit, lens
, pretty, QuickCheck, stdenv
}:
mkDerivation {
  pname = "language-nix";
  version = "2.1";
  src = fetchgit {
    url = "git://github.com/peti/language-nix.git";
    sha256 = "5491f66b6c8a5abcc572ad1791a7f5a5352634ff994727fe1a077fcf5f7a0439";
    rev = "6631ad24127c756e8dfce199091cee81ace4f9a9";
  };
  libraryHaskellDepends = [
    base Cabal deepseq lens pretty QuickCheck
  ];
  testHaskellDepends = [
    base Cabal deepseq doctest lens pretty QuickCheck
  ];
  homepage = "https://github.com/peti/language-nix#readme";
  description = "Data types and useful functions to represent and manipulate the Nix language";
  license = stdenv.lib.licenses.bsd3;
}
