{ mkDerivation, base, fetchgit, nix, process, stdenv }:
mkDerivation {
  pname = "nix-paths";
  version = "1";
  src = fetchgit {
    url = "git://github.com/peti/nix-paths.git";
    sha256 = "60a68389523cbbfaeb9ac7da57930c6d88decf85dcbfef8e95dd29220b537d46";
    rev = "a208463f9fd26f8a69d7547cbac5a97ca3651162";
  };
  libraryHaskellDepends = [ base process ];
  libraryToolDepends = [ nix ];
  homepage = "https://github.com/peti/nix-paths";
  description = "Knowledge of Nix's installation directories";
  license = stdenv.lib.licenses.bsd3;
}
