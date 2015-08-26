{ mkDerivation, base, binary, bytestring, fetchgit, HUnit
, QuickCheck, stdenv, test-framework, test-framework-hunit
, test-framework-quickcheck2
}:
mkDerivation {
  pname = "largeword";
  version = "1.2.4";
  src = fetchgit {
    url = "git://github.com/idontgetoutmuch/largeword.git";
    sha256 = "6c41e67578a42859377c57e4302b41d979e30ce40bfcb29d3e6cfcbc33501bb8";
    rev = "7abd809c137281d29fd5c49f1f1c3f086b75648c";
  };
  libraryHaskellDepends = [ base binary ];
  testHaskellDepends = [
    base binary bytestring HUnit QuickCheck test-framework
    test-framework-hunit test-framework-quickcheck2
  ];
  homepage = "https://github.com/idontgetoutmuch/largeword";
  description = "Provides Word128, Word192 and Word256 and a way of producing other large words if required";
  license = stdenv.lib.licenses.bsd3;
}
