{ mkDerivation, aeson, base, bytestring, Cabal, containers, deepseq
, doctest, fetchgit, hspec, language-nix, lens, pretty, process
, QuickCheck, split, stdenv
}:
mkDerivation {
  pname = "distribution-nixpkgs";
  version = "1";
  src = fetchgit {
    url = "git://github.com/peti/distribution-nixpkgs.git";
    sha256 = "0sms8nr4d0rwxzzb7djlwp455ybj36q5apjdjkw4nzhkawp9nk25";
    rev = "944e7ddc143d5763f46c59d9740e3af820e85938";
  };
  libraryHaskellDepends = [
    aeson base bytestring Cabal containers deepseq language-nix lens
    pretty process split
  ];
  testHaskellDepends = [
    aeson base bytestring Cabal containers deepseq doctest hspec
    language-nix lens pretty process QuickCheck split
  ];
  homepage = "https://github.com/peti/distribution-nixpkgs#readme";
  description = "Types and functions to manipulate the Nixpkgs distribution";
  license = stdenv.lib.licenses.bsd3;
}
