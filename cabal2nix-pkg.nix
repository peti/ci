{ mkDerivation, aeson, ansi-wl-pprint, base, bytestring, Cabal
, cabal-doctest, containers, deepseq, directory
, distribution-nixpkgs, doctest, fetchgit, filepath, hackage-db
, hopenssl, language-nix, lens, monad-par, monad-par-extras, mtl
, optparse-applicative, pretty, process, split, stdenv, text, time
, transformers, utf8-string, yaml
}:
mkDerivation {
  pname = "cabal2nix";
  version = "2.3";
  src = fetchgit {
    url = "git://github.com/NixOS/cabal2nix.git";
    sha256 = "1ddnjgvndl6mn2q1y6a4rdd5i21d26nhnrwpvp1hiny8z846n48h";
    rev = "4ff71879d053fd07da58ceeef25418e8ef86af4f";
  };
  isLibrary = true;
  isExecutable = true;
  setupHaskellDepends = [ base Cabal cabal-doctest ];
  libraryHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs filepath hackage-db hopenssl
    language-nix lens optparse-applicative pretty process split text
    transformers yaml
  ];
  executableHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs filepath hackage-db hopenssl
    language-nix lens monad-par monad-par-extras mtl
    optparse-applicative pretty process split text time transformers
    utf8-string yaml
  ];
  testHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs doctest filepath hackage-db hopenssl
    language-nix lens optparse-applicative pretty process split text
    transformers yaml
  ];
  homepage = "https://github.com/nixos/cabal2nix#readme";
  description = "Convert Cabal files into Nix build instructions";
  license = stdenv.lib.licenses.bsd3;
}
