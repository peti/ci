{ mkDerivation, aeson, ansi-wl-pprint, base, bytestring, Cabal
, containers, deepseq, directory, distribution-nixpkgs, fetchgit
, filepath, hackage-db, hopenssl, hpack, language-nix, lens
, monad-par, monad-par-extras, mtl, optparse-applicative, pretty
, process, split, stdenv, tasty, tasty-golden, text, time
, transformers, yaml
}:
mkDerivation {
  pname = "cabal2nix";
  version = "2.9.2";
  src = fetchgit {
    url = "git://github.com/NixOS/cabal2nix.git";
    sha256 = "1v9811zrlv3cmc07a46i6nzab4xz9nlxakrqcj7wn5sawrc236v4";
    rev = "5b271abdcc771da46dc45ca781788c73c0b3dd9f";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs filepath hackage-db hopenssl hpack
    language-nix lens optparse-applicative pretty process split text
    time transformers yaml
  ];
  executableHaskellDepends = [
    aeson base bytestring Cabal containers directory
    distribution-nixpkgs filepath hopenssl language-nix lens monad-par
    monad-par-extras mtl optparse-applicative pretty
  ];
  testHaskellDepends = [
    base Cabal filepath language-nix lens pretty tasty tasty-golden
  ];
  homepage = "https://github.com/nixos/cabal2nix#readme";
  description = "Convert Cabal files into Nix build instructions";
  license = stdenv.lib.licenses.bsd3;
}
