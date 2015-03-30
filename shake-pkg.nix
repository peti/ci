{ mkDerivation, base, binary, bytestring, deepseq, directory, extra
, fetchgit, filepath, hashable, js-flot, js-jquery, old-time
, process, QuickCheck, random, stdenv, time, transformers, unix
, unordered-containers, utf8-string
}:
mkDerivation {
  pname = "shake";
  version = "0.15";
  src = fetchgit {
    url = "git://github.com/ndmitchell/shake.git";
    sha256 = "143f73127293d68458059972be510a9934b612a8423b87fc761f8e8850af0db5";
    rev = "400114857f3d9ef4398d913a3fe454a754423a85";
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
  homepage = "http://shakebuild.com";
  description = "Build system library, like Make, but more accurate dependencies";
  license = stdenv.lib.licenses.bsd3;
}
