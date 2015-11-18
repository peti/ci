/* Essential Haskell packages in Nixpkgs that must build. */

{ buildAllNGPackages ? false
, buildDarwin ? false
, supportedSystems ? ["x86_64-linux"] ++ (if buildDarwin then ["x86_64-darwin"] else [])
}:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc6104 = "ghc6104";
  ghc6123 = "ghc6123";
  ghc704  = "ghc704";
  ghc722  = "ghc722";
  ghc742  = "ghc742";
  ghc763  = "ghc763";
  ghc784  = "ghc784";
  ghc7102 = "ghc7102";
  ghcHEAD = "ghcHEAD";
  default = [ ghc7102 ];
  all     = [ /*ghc6123*/ ghc704 ghc722 ghc742 ghc763 ghc784 ghc7102 /*ghcHEAD*/ ];

  allBut = platforms: pkgs.lib.filter (x: !(pkgs.lib.elem x platforms)) all;

  filterSupportedSystems = systems: pkgs.lib.filter (x: pkgs.lib.elem x supportedSystems) systems;

  mapHaskellTestOn = attrs: pkgs.lib.mapAttrs mkJobs attrs;

  mkJobs = pkg: ghcs: builtins.listToAttrs (pkgs.lib.concatMap (ghc: mkJob ghc pkg) ghcs);

  mkJob = ghc: pkg:
    let
      pkgPath = ["haskell" "packages" ghc pkg];
      systems = filterSupportedSystems (pkgs.lib.attrByPath (pkgPath ++ ["meta" "platforms"]) [] pkgs);
    in
      map (system: mkSystemJob system ghc pkg) systems;

  mkSystemJob = system: ghc: pkg:
    pkgs.lib.nameValuePair "${ghc}" (pkgs.lib.setAttrByPath [system] ((pkgs.lib.getAttrFromPath ["haskell" "packages" ghc pkg] (pkgsFor system))));

in

pkgs.lib.optionalAttrs buildAllNGPackages (mapTestOn {

  cryptol = supportedSystems;
  darcs = supportedSystems;
  emacsPackages.haskellMode = supportedSystems;
  gitAndTools.git-annex = supportedSystems;
  hugs = supportedSystems;
  pandoc = supportedSystems;

  haskell.compiler = packagePlatforms pkgs.haskell.compiler;
  haskellPackages = packagePlatforms pkgs.haskellPackages;
  # haskell.packages.lts-0_0 = packagePlatforms pkgs.haskell.packages.lts-0_0;
  # haskell.packages.lts-0_1 = packagePlatforms pkgs.haskell.packages.lts-0_1;
  # haskell.packages.lts-0_2 = packagePlatforms pkgs.haskell.packages.lts-0_2;
  # haskell.packages.lts-0_3 = packagePlatforms pkgs.haskell.packages.lts-0_3;
  # haskell.packages.lts-0_4 = packagePlatforms pkgs.haskell.packages.lts-0_4;
  # haskell.packages.lts-0_5 = packagePlatforms pkgs.haskell.packages.lts-0_5;
  # haskell.packages.lts-0_6 = packagePlatforms pkgs.haskell.packages.lts-0_6;
  # haskell.packages.lts-0_7 = packagePlatforms pkgs.haskell.packages.lts-0_7;
  # haskell.packages.lts-1_0 = packagePlatforms pkgs.haskell.packages.lts-1_0;
  # haskell.packages.lts-1_1 = packagePlatforms pkgs.haskell.packages.lts-1_1;
  # haskell.packages.lts-1_2 = packagePlatforms pkgs.haskell.packages.lts-1_2;
  # haskell.packages.lts-1_4 = packagePlatforms pkgs.haskell.packages.lts-1_4;
  # haskell.packages.lts-1_5 = packagePlatforms pkgs.haskell.packages.lts-1_5;
  # haskell.packages.lts-1_7 = packagePlatforms pkgs.haskell.packages.lts-1_7;
  # haskell.packages.lts-1_8 = packagePlatforms pkgs.haskell.packages.lts-1_8;
  # haskell.packages.lts-1_9 = packagePlatforms pkgs.haskell.packages.lts-1_9;
  # haskell.packages.lts-1_10 = packagePlatforms pkgs.haskell.packages.lts-1_10;
  # haskell.packages.lts-1_11 = packagePlatforms pkgs.haskell.packages.lts-1_11;
  # haskell.packages.lts-1_12 = packagePlatforms pkgs.haskell.packages.lts-1_12;
  # haskell.packages.lts-1_13 = packagePlatforms pkgs.haskell.packages.lts-1_13;
  # haskell.packages.lts-1_14 = packagePlatforms pkgs.haskell.packages.lts-1_14;
  # haskell.packages.lts-1_15 = packagePlatforms pkgs.haskell.packages.lts-1_15;
  # haskell.packages.lts-2_0 = packagePlatforms pkgs.haskell.packages.lts-2_0;
  # haskell.packages.lts-2_1 = packagePlatforms pkgs.haskell.packages.lts-2_1;
  # haskell.packages.lts-2_2 = packagePlatforms pkgs.haskell.packages.lts-2_2;
  # haskell.packages.lts-2_3 = packagePlatforms pkgs.haskell.packages.lts-2_3;
  # haskell.packages.lts-2_4 = packagePlatforms pkgs.haskell.packages.lts-2_4;
  # haskell.packages.lts-2_5 = packagePlatforms pkgs.haskell.packages.lts-2_5;
  # haskell.packages.lts-2_6 = packagePlatforms pkgs.haskell.packages.lts-2_6;
  # haskell.packages.lts-2_7 = packagePlatforms pkgs.haskell.packages.lts-2_7;
  # haskell.packages.lts-2_8 = packagePlatforms pkgs.haskell.packages.lts-2_8;
  # haskell.packages.lts-2_9 = packagePlatforms pkgs.haskell.packages.lts-2_9;
  # haskell.packages.lts-2_10 = packagePlatforms pkgs.haskell.packages.lts-2_10;
  # haskell.packages.lts-2_11 = packagePlatforms pkgs.haskell.packages.lts-2_11;
  # haskell.packages.lts-2_12 = packagePlatforms pkgs.haskell.packages.lts-2_12;
  # haskell.packages.lts-2_13 = packagePlatforms pkgs.haskell.packages.lts-2_13;
  # haskell.packages.lts-2_14 = packagePlatforms pkgs.haskell.packages.lts-2_14;
  # haskell.packages.lts-2_15 = packagePlatforms pkgs.haskell.packages.lts-2_15;
  # haskell.packages.lts-2_16 = packagePlatforms pkgs.haskell.packages.lts-2_16;
  # haskell.packages.lts-2_17 = packagePlatforms pkgs.haskell.packages.lts-2_17;
  # haskell.packages.lts-2_18 = packagePlatforms pkgs.haskell.packages.lts-2_18;
  # haskell.packages.lts-2_19 = packagePlatforms pkgs.haskell.packages.lts-2_19;
  # haskell.packages.lts-2_20 = packagePlatforms pkgs.haskell.packages.lts-2_20;
  # haskell.packages.lts-2_21 = packagePlatforms pkgs.haskell.packages.lts-2_21;
  # haskell.packages.lts-2_22 = packagePlatforms pkgs.haskell.packages.lts-2_22;
  # haskell.packages.lts-3_0 = packagePlatforms pkgs.haskell.packages.lts-3_0;
  # haskell.packages.lts-3_1 = packagePlatforms pkgs.haskell.packages.lts-3_1;
  # haskell.packages.lts-3_2 = packagePlatforms pkgs.haskell.packages.lts-3_2;
  # haskell.packages.lts-3_3 = packagePlatforms pkgs.haskell.packages.lts-3_3;
  # haskell.packages.lts-3_4 = packagePlatforms pkgs.haskell.packages.lts-3_4;
  # haskell.packages.lts-3_5 = packagePlatforms pkgs.haskell.packages.lts-3_5;
  # haskell.packages.lts-3_6 = packagePlatforms pkgs.haskell.packages.lts-3_6;
  # haskell.packages.lts-3_7 = packagePlatforms pkgs.haskell.packages.lts-3_7;
  # haskell.packages.lts-3_8 = packagePlatforms pkgs.haskell.packages.lts-3_8;
  # haskell.packages.lts-3_9 = packagePlatforms pkgs.haskell.packages.lts-3_9;
  # haskell.packages.lts-3_10 = packagePlatforms pkgs.haskell.packages.lts-3_10;
  # haskell.packages.lts-3_11 = packagePlatforms pkgs.haskell.packages.lts-3_11;
  # haskell.packages.lts-3_12 = packagePlatforms pkgs.haskell.packages.lts-3_12;
  # haskell.packages.lts-3_13 = packagePlatforms pkgs.haskell.packages.lts-3_13;
  haskell.packages.lts-3_14 = packagePlatforms pkgs.haskell.packages.lts-3_14;

})
// mapHaskellTestOn {

  alex = allBut [ghcHEAD];
  async = allBut [ghc6123];
  Cabal = all;
  Cabal_1_18_1_6 = [ghc704 ghc722 ghc742 ghc763 ghc784 ghc7102];
  Cabal_1_20_0_3 = [ghc704 ghc722 ghc742 ghc763 ghc784];
  Cabal_1_22_1_0 = [ghc722 ghc742 ghc763 ghc784 ghc7102 ghcHEAD];
  cabal2nix = default;
  cabal-install = allBut [ghc6123 ghcHEAD];
  case-insensitive = all;
  cpphs = all;
  data-memocombinators = all;
  doctest = allBut [ghc6123];
  fgl = all;
  funcmp = all;
  ghc = all;
  ghc-paths = all;
  GLUT = allBut [ghc6123];
  hackage-db = all;
  haddock = default;
  happy = all;
  hashable = all;
  hashtables = allBut [ghc6123];
  haskell-src = all;
  hledger = default;
  hopenssl = all;
  hsdns = all;
  hsemail = allBut [ghc6123];
  hsyslog = all;
  html = all;
  HTTP = all;
  HUnit = all;
  IfElse = all;
  jailbreak-cabal = all;
  monad-loops = all;
  monad-par = allBut [ghcHEAD];
  mtl = all;
  nats = allBut [ghc6123];
  network = all;
  OpenGL = allBut [ghc6123];
  parallel = all;
  parsec = all;
  polyparse = all;
  primitive = all;
  QuickCheck = all;
  regex-base = all;
  regex-compat = all;
  regex-posix = all;
  regex-TDFA = all;
  split = all;
  stm = all;
  streamproc = all;
  syb = allBut [ghc6123];
  tar = all;
  text = all;
  transformers-compat = allBut [ghc6123];
  transformers = [/*ghc6123*/ ghc704 ghc722 ghc742 ghc763];
  unix-time = allBut [ghc6123];
  unordered-containers = allBut [ghc6123];
  vector = all;
  wizards = default;
  wl-pprint = all;
  zlib = all;

}
