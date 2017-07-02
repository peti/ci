{ mkDerivation, aeson, ansi-wl-pprint, base, bytestring, Cabal
, containers, deepseq, directory, distribution-nixpkgs, doctest
, fetchgit, filepath, hackage-db, hopenssl, language-nix, lens
, monad-par, monad-par-extras, mtl, optparse-applicative, pretty
, process, split, stdenv, text, time, transformers, utf8-string
, yaml
}:
mkDerivation {
  pname = "cabal2nix";
  version = "2.3";
  src = fetchgit {
    url = "git://github.com/NixOS/cabal2nix.git";
    sha256 = "1hi876l6skx0wsdcj194zy8adhgi0m2pz0k0dbn4z4qxvik7c57v";
    rev = "5c18fb530ced48f35549543943f8e0c8ddaf5686";
  };
  isLibrary = true;
  isExecutable = true;
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
