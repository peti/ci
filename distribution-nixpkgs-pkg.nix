{ mkDerivation, aeson, base, bytestring, Cabal, containers, deepseq
, doctest, fetchgit, hspec, language-nix, lens, pretty, process
, split, stdenv
}:
mkDerivation {
  pname = "distribution-nixpkgs";
  version = "1.1";
  src = fetchgit {
    url = "git://github.com/peti/distribution-nixpkgs.git";
    sha256 = "1gl64fnydwfr3jk4bkp4z53ngv4rnasb55h0j2ym1srp4rc45wg2";
    rev = "cdc5202b4663d7a347912292c00f63b3c5dceabd";
  };
  libraryHaskellDepends = [
    aeson base bytestring Cabal containers deepseq language-nix lens
    pretty process split
  ];
  testHaskellDepends = [ base deepseq doctest hspec lens ];
  homepage = "https://github.com/peti/distribution-nixpkgs#readme";
  description = "Types and functions to manipulate the Nixpkgs distribution";
  license = stdenv.lib.licenses.bsd3;
}
