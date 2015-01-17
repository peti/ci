{ mkDerivation, base, binary, bytestring, deepseq, directory, extra
, fetchgit, filepath, hashable, js-flot, js-jquery, old-time
, process, QuickCheck, random, stdenv, time, transformers, unix
, unordered-containers, utf8-string
}:
mkDerivation {
  pname = "shake";
  version = "0.14.3";
  src = fetchgit {
    url = "git://github.com/ndmitchell/shake.git";
    sha256 = "63ae26b3cdbd5007c100b83fc6e9a1e291b9c2aace0ae3c880b5cda3b4c0c11d";
    rev = "d44aaf4e1bd018c993d586f0e09ac7755a99bf06";
  };
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    base binary bytestring deepseq directory extra filepath hashable
    js-flot js-jquery old-time process random time transformers unix
    unordered-containers utf8-string
  ];
  testDepends = [
    base binary bytestring deepseq directory extra filepath hashable
    js-flot js-jquery old-time process QuickCheck random time
    transformers unix unordered-containers utf8-string
  ];
  homepage = "http://www.shakebuild.com/";
  description = "Build system library, like Make, but more accurate dependencies";
  license = stdenv.lib.licenses.bsd3;
}
