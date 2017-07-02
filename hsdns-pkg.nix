{ mkDerivation, adns, base, containers, fetchgit, network, stdenv
}:
mkDerivation {
  pname = "hsdns";
  version = "1.7";
  src = fetchgit {
    url = "git://github.com/peti/hsdns.git";
    sha256 = "1qf8wair70n3h2k9j2rmbf4qgs300z13fiiqrs6qgwcb25dz5mlj";
    rev = "f6cf676e22b6f78ee6a4d1fda8a8309c56bc0476";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base containers network ];
  librarySystemDepends = [ adns ];
  homepage = "http://github.com/peti/hsdns";
  description = "Asynchronous DNS Resolver";
  license = stdenv.lib.licenses.lgpl3;
}
