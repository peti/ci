{ mkDerivation, base, doctest, fetchgit, stdenv }:
mkDerivation {
  pname = "hsyslog";
  version = "5";
  src = fetchgit {
    url = "git://github.com/peti/hsyslog.git";
    sha256 = "023cby8p06jxnwikwadsvdqbgvg4dmrcz7b3cpf4cjv6hajzyabs";
    rev = "e538d00de652a3bfe563e96edd88b67993272a40";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  testHaskellDepends = [ base doctest ];
  homepage = "http://github.com/peti/hsyslog";
  description = "FFI interface to syslog(3) from POSIX.1-2001";
  license = stdenv.lib.licenses.bsd3;
}
