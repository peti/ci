{ mkDerivation, base, binary, bytestring, fetchgit, HUnit
, QuickCheck, stdenv, test-framework, test-framework-hunit
, test-framework-quickcheck2
}:
mkDerivation {
  pname = "largeword";
  version = "1.2.3";
  src = fetchgit {
    url = "git://github.com/idontgetoutmuch/largeword.git";
    sha256 = "4f9be69ea9c1a55977ca3fafd1dd7a7b708c49ad4a797476afa2f9cc7ca0a1fa";
    rev = "50978f18168c37da7c9ee73bdb545131ac40b9c9";
  };
  buildDepends = [ base binary ];
  testDepends = [
    base binary bytestring HUnit QuickCheck test-framework
    test-framework-hunit test-framework-quickcheck2
  ];
  homepage = "https://github.com/idontgetoutmuch/largeword";
  description = "Provides Word128, Word192 and Word256 and a way of producing other large words if required";
  license = stdenv.lib.licenses.bsd3;
}
