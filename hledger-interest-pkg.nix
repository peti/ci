{ mkDerivation, base, Cabal, Decimal, fetchgit, hledger-lib, mtl
, parsec, stdenv, time
}:
mkDerivation {
  pname = "hledger-interest";
  version = "1.5";
  src = fetchgit {
    url = "git://github.com/peti/hledger-interest.git";
    sha256 = "54ed90e78ea98e13c502f688c8c95fbe49d1cfd7fff1e66c4e8af042dfafb2a4";
    rev = "11249f31c57b10fb582f8df3391e969ca2a514bd";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base Cabal Decimal hledger-lib mtl parsec time
  ];
  homepage = "http://github.com/peti/hledger-interest";
  description = "computes interest for a given account";
  license = stdenv.lib.licenses.bsd3;
}
