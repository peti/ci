{ mkDerivation, base, doctest, fetchgit, stdenv }:
mkDerivation {
  pname = "hsyslog";
  version = "2.0";
  src = fetchgit {
    url = "git://github.com/peti/hsyslog.git";
    sha256 = "ef82cd0697206d2616195aeeec823a02ceee2373a644e4d8694b448c0bf96b0c";
    rev = "ae374d72f9cf65eea308a419587893db4e5c4505";
  };
  buildDepends = [ base ];
  testDepends = [ base doctest ];
  homepage = "http://github.com/peti/hsyslog";
  description = "FFI interface to syslog(3) from POSIX.1-2001";
  license = stdenv.lib.licenses.bsd3;
}
