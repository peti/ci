{ mkDerivation, base, fetchgit, stdenv }:
mkDerivation {
  pname = "hsyslog";
  version = "3";
  src = fetchgit {
    url = "git://github.com/peti/hsyslog.git";
    sha256 = "9c69bd28ac36a35c00e9c7415710f5bedab5ba980f697f4d5272961991fb50d7";
    rev = "cf6be8a612995502853b187cc9cdc83c835cce30";
  };
  buildDepends = [ base ];
  homepage = "http://github.com/peti/hsyslog";
  description = "FFI interface to syslog(3) from POSIX.1-2001";
  license = stdenv.lib.licenses.bsd3;
}
