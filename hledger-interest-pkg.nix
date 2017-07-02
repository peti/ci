{ mkDerivation, base, Cabal, Decimal, fetchgit, hledger-lib, mtl
, stdenv, text, time
}:
mkDerivation {
  pname = "hledger-interest";
  version = "1.5.1";
  src = fetchgit {
    url = "git://github.com/peti/hledger-interest.git";
    sha256 = "1m2ps4amc9rpqk19v8g682khhhplb5kjgh6bpjml02adn776ggjz";
    rev = "1f38ae5f858269a99f3aab85204077c4e857e778";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base Cabal Decimal hledger-lib mtl text time
  ];
  homepage = "http://github.com/peti/hledger-interest";
  description = "computes interest for a given account";
  license = stdenv.lib.licenses.bsd3;
}
