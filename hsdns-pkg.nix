{ mkDerivation, adns, base, containers, fetchgit, network, stdenv
}:
mkDerivation {
  pname = "hsdns";
  version = "1.6.1";
  src = fetchgit {
    url = "git://github.com/peti/hsdns.git";
    sha256 = "786372383ff0d6ec50d06dfc812fe975fb20cf88fe837837123dadd9a9daf516";
    rev = "cb42aa8ac9e8820e53cb5629ae3c052e6a4993d9";
  };
  libraryHaskellDepends = [ base containers network ];
  librarySystemDepends = [ adns ];
  homepage = "http://github.com/peti/hsdns";
  description = "Asynchronous DNS Resolver";
  license = stdenv.lib.licenses.gpl3;
}
