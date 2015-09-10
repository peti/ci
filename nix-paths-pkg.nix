{ mkDerivation, base, fetchgit, nix, process, stdenv
}:
mkDerivation {
  pname = "nix-paths";
  version = "1";
  src = fetchgit {
    url = "git://github.com/peti/nix-paths.git";
    sha256 = "4d4139b6defabd1f864165224e79f7cc618c437a088d28408665cd8b3c7f7f40";
    rev = "e199a9691fd6478ba21799947dcc63759f8d785f";
  };
  libraryHaskellDepends = [ base process ];
  libraryToolDepends = [ nix ];
  homepage = "https://github.com/nixos/cabal2nix#readme";
  description = "Knowledge of Nix's installation directories";
  license = stdenv.lib.licenses.bsd3;
}
