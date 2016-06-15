{ mkDerivation, aeson, ansi-wl-pprint, base, bytestring, Cabal
, containers, deepseq, directory, distribution-nixpkgs, fetchgit
, filepath, hackage-db, language-nix, lens, monad-par
, monad-par-extras, mtl, optparse-applicative, pretty, process, SHA
, split, stackage-types, stdenv, text, time, transformers
, utf8-string, yaml
}:
mkDerivation {
  pname = "cabal2nix";
  version = "20160613";
  src = fetchgit {
    url = "git://github.com/NixOS/cabal2nix.git";
    sha256 = "0bp1394vgfws2z6j8qnicvj1s6g2dx0snhqzlaclyqkaq256hq06";
    rev = "1b9ba52ce78a5eba8bb68d12be5fa9c631e863c8";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs filepath hackage-db language-nix
    lens optparse-applicative pretty process SHA split text
    transformers yaml
  ];
  executableHaskellDepends = [
    aeson ansi-wl-pprint base bytestring Cabal containers deepseq
    directory distribution-nixpkgs filepath hackage-db language-nix
    lens monad-par monad-par-extras mtl optparse-applicative pretty
    process SHA split stackage-types text time transformers utf8-string
    yaml
  ];
  homepage = "https://github.com/nixos/cabal2nix#readme";
  description = "Convert Cabal files into Nix build instructions";
  license = stdenv.lib.licenses.bsd3;
}
