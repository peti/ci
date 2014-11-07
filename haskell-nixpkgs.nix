/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? [ "x86_64-linux" ] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  linux = import <nixpkgs/pkgs/top-level/release-lib.nix> { supportedSystems = [ "i686-linux" "x86_64-linux" ]; };

  ghc6104 = "ghc6104";
  ghc6123 = "ghc6123";
  ghc704  = "ghc704";
  ghc722  = "ghc722";
  ghc742  = "ghc742";
  ghc763  = "ghc763";
  ghc783  = "ghc783";
  ghcHEAD = "ghcHEAD";
  default = [ ghc783 ];
  all     = [ ghc6104 ghc6123 ghc704 ghc722 ghc742 ghc763 ghc783 ];

  allBut = platforms: pkgs.lib.filter (x: !(pkgs.lib.elem x platforms)) all;

  filterSupportedSystems = systems: pkgs.lib.filter (x: pkgs.lib.elem x supportedSystems) systems;

  mapHaskellTestOn = attrs: pkgs.lib.mapAttrs mkJobs attrs;

  mkJobs = pkg: ghcs: builtins.listToAttrs (pkgs.lib.concatMap (ghc: mkJob ghc pkg) ghcs);

  mkJob = ghc: pkg:
    let
      pkgPath = ["haskellPackages_${ghc}" "${pkg}"];
      systems = filterSupportedSystems (pkgs.lib.attrByPath (pkgPath ++ ["meta" "platforms"]) [] pkgs);
    in
      map (system: mkSystemJob system ghc pkg) systems;

  mkSystemJob = system: ghc: pkg:
    pkgs.lib.nameValuePair "${ghc}" (pkgs.lib.setAttrByPath [system] ((pkgs.lib.getAttrFromPath ["haskellPackages_${ghc}" "${pkg}"] (pkgsFor system))));

in

linux.mapTestOn {

  # Build GHC in 32-bit, too, because hydra.nixos.org cannot do that for
  # reasons nobody understands.
  #haskellPackages.ghcPlain = [ "i686-linux" "x86_64-linux" ];

}
//
mapTestOn {

  cryptol2 = supportedSystems;
  darcs = supportedSystems;
  # gitAndTools.gitAnnex = supportedSystems;
  jhc = supportedSystems;

  haskellPlatformPackages."2009_2_0_2" = supportedSystems;
  #haskellPlatformPackages."2010_1_0_0" = supportedSystems;
  haskellPlatformPackages."2010_2_0_0" = supportedSystems;
  #haskellPlatformPackages."2011_2_0_0" = supportedSystems;
  #haskellPlatformPackages."2011_2_0_1" = supportedSystems;
  haskellPlatformPackages."2011_4_0_0" = supportedSystems;
  haskellPlatformPackages."2012_2_0_0" = supportedSystems;
  haskellPlatformPackages."2012_4_0_0" = supportedSystems;
  haskellPlatformPackages."2013_2_0_0" = supportedSystems;

  haskellPackages = packagesWithMetaPlatform pkgs.haskellPackages;

}
//
mapHaskellTestOn {

  alex = all;
  async = allBut [ghc6104 ghc6123];
  attoparsec = allBut [ghc6104];
  Cabal_1_14_0 = [ ghc6104 ghc6123 ghc704 ];
  Cabal_1_16_0_3 = [ ghc6104 ghc6123 ghc704 ghc722 ghc742 ghc763 ];
  Cabal_1_18_1_3 = [ ghc704 ghc722 ghc742 ghc763 ghc783 ];
  Cabal_1_20_0_2 = [ ghc704 ghc722 ghc742 ghc763 ghc783 ];
  cabal2nix = allBut [ghc6104 ghc6123];
  cabalInstall_1_20_0_3 = allBut [ ghc6104 ghc6123 ];
  cabalInstall = all;
  caseInsensitive = all;
  cmdlib = allBut [ghc6104];
  cpphs = all;
  dataMemocombinators = all;
  doctest = allBut [ghc6104 ghc6123];
  fgl = all;
  funcmp = all;
  ghc = all;
  ghcPaths = all;
  GLUT = allBut [ghc6104];
  hackageDb = all;
  haddock = allBut [ghc722];
  happy = all;
  hashable = allBut [ghc6104];
  hashtables = all;
  haskellSrc = all;
  hopenssl = all;
  hsdns = all;
  hsemail = allBut [ghc6104 ghc6123];
  hsyslog = all;
  html = all;
  HTTP = all;
  HUnit = all;
  IfElse = all;
  jailbreakCabal = all;
  monadLoops = allBut [ghc6104];
  monadPar = allBut [ghc6104];
  mtl = all;
  nats = allBut [ghc6104 ghc6123];
  network = all;
  OpenGL = allBut [ghc6104];
  parallel = all;
  parsec = all;
  permutation = all;
  polyparse = all;
  primitive = all;
  QuickCheck = all;
  regexBase = all;
  regexCompat = all;
  regexPosix = all;
  regexTDFA = allBut [ghc6104];
  scientific = allBut [ghc6104 ghc6123];
  split = all;
  stm = all;
  streamproc = all;
  syb = allBut [ghc6104 ghc6123];
  systemFileio = all;
  systemFilepath = all;
  tar = all;
  text = all;
  transformers = [ ghc6104 ghc6123 ghc704 ghc722 ghc742 ghc763 ];
  unixTime = allBut [ghc6104 ghc6123];
  unorderedContainers = allBut [ghc6104 ghc6123];
  vector = all;
  wlPprint = all;
  xhtml = all;
  zlib = all;

}
