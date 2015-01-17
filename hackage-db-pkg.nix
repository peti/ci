{ mkDerivation, base, bytestring, Cabal, containers, directory
, fetchgit, filepath, stdenv, tar, utf8-string
}:
mkDerivation {
  pname = "hackage-db";
  version = "1.23";
  src = fetchgit {
    url = "git://github.com/peti/hackage-db.git";
    sha256 = "214030ce5794b6684d6a5b3ad49538b42492f206a1186e95aeba70cdc38c98db";
    rev = "0b32fe92f54a607c780b8c4674f359ce63d599bd";
  };
  buildDepends = [
    base bytestring Cabal containers directory filepath tar utf8-string
  ];
  homepage = "http://github.com/peti/hackage-db";
  description = "access Hackage's package database via Data.Map";
  license = stdenv.lib.licenses.bsd3;
}
