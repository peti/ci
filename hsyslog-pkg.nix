{ mkDerivation, base, bytestring, fetchgit, QuickCheck, stdenv }:
mkDerivation {
  pname = "hsyslog";
  version = "3";
  src = fetchgit {
    url = "git://github.com/peti/hsyslog.git";
    sha256 = "29174424d0a2d8f4a313950aa6e2c20e057fb1c5aabde79ffa60add7998cdeaa";
    rev = "f2c4ee8da880a5e885463da769168413f6972291";
  };
  libraryHaskellDepends = [ base bytestring ];
  testHaskellDepends = [ base bytestring QuickCheck ];
  homepage = "http://github.com/peti/hsyslog";
  description = "FFI interface to syslog(3) from POSIX.1-2001";
  license = stdenv.lib.licenses.bsd3;
}
