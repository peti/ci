{ mkDerivation, adns, base, containers, fetchgit, network, stdenv
}:
mkDerivation {
  pname = "hsdns";
  version = "1.6.1";
  src = fetchgit {
    url = "git://github.com/peti/hsdns.git";
    sha256 = "16ycmr3x2fhk4irqirgckrxhk2mrqyg1hghb5lc64d1b83115wna";
    rev = "932ea9466db7c3ace7e83ef0e58bb593bc1a8e02";
  };
  libraryHaskellDepends = [ base containers network ];
  librarySystemDepends = [ adns ];
  homepage = "http://github.com/peti/hsdns";
  description = "Asynchronous DNS Resolver";
  license = stdenv.lib.licenses.lgpl3;
}
