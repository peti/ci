{ mkDerivation, base, deepseq, doctest, fetchgit, lens, pretty
, prettyclass, QuickCheck, regex-posix, stdenv, ghc
}:

mkDerivation {
  pname = "language-nix";
  version = "2";
  src = fetchgit {
    url = "git://github.com/peti/language-nix.git";
    sha256 = "33e46fe4acf182487386b06c0eaf7076c1a77ceb1d9111e804a28424e7c302c1";
    rev = "3a287152877cf10f3bb052b5ccc2906357f02f01";
  };
  libraryHaskellDepends = [
    base deepseq lens pretty regex-posix
  ] ++ stdenv.lib.optional (stdenv.lib.versionOlder ghc.version "7.10") prettyclass;
  testHaskellDepends = [
    base deepseq doctest lens pretty QuickCheck regex-posix
  ] ++ stdenv.lib.optional (stdenv.lib.versionOlder ghc.version "7.10") prettyclass;
  homepage = "https://github.com/peti/language-nix#readme";
  description = "Data types and useful functions to represent and manipulate the Nix language";
  license = stdenv.lib.licenses.bsd3;
}
