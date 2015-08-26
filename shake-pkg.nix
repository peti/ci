{ mkDerivation, base, binary, bytestring, deepseq, directory, extra
, fetchgit, filepath, hashable, js-flot, js-jquery, old-time
, process, QuickCheck, random, stdenv, time, transformers, unix
, unordered-containers, utf8-string
}:
mkDerivation {
  pname = "shake";
  version = "0.15.5";
  src = fetchgit {
    url = "git://github.com/ndmitchell/shake.git";
    sha256 = "081198a3f6087fa48d22f3683907850db17c0c76ebf479ad970d8687f41042c5";
    rev = "45bbd6fe52a691ecf46256d34761f9e5c16ef3b2";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base binary bytestring deepseq directory extra filepath hashable
    js-flot js-jquery old-time process random time transformers unix
    unordered-containers utf8-string
  ];
  executableHaskellDepends = [
    base binary bytestring deepseq directory extra filepath hashable
    js-flot js-jquery old-time process random time transformers unix
    unordered-containers utf8-string
  ];
  testHaskellDepends = [
    base binary bytestring deepseq directory extra filepath hashable
    js-flot js-jquery old-time process QuickCheck random time
    transformers unix unordered-containers utf8-string
  ];
  homepage = "http://shakebuild.com";
  description = "Build system library, like Make, but more accurate dependencies";
  license = stdenv.lib.licenses.bsd3;
}
