/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? [ "x86_64-linux" ], big ? false }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

let

  ghc6123 = "ghc6123";
  ghc704  = "ghc704";
  ghc722  = "ghc722";
  ghc742  = "ghc742";
  ghc763  = "ghc763";
  ghc784  = "ghc784";
  ghc7101 = "ghc7101";
  ghcHEAD = "ghcHEAD";
  default = [ ghc784 ];
  all     = [ ghc6123 ghc704 ghc722 ghc742 ghc763 ghc784 ghc7101 ghcHEAD ];

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
    pkgs.lib.nameValuePair "${ghc}" (pkgs.lib.setAttrByPath [system] ((pkgs.lib.getAttrFromPath ["haskell-ng" "packages" ghc pkg] (pkgsFor system))));

in

pkgs.lib.optionalAttrs big (mapTestOn {

  cryptol = supportedSystems;
  darcs = supportedSystems;
  jhc = supportedSystems;
  pandoc = supportedSystems;
  uhc = supportedSystems;

  haskell-ng.compiler = packagesWithMetaPlatform pkgs.haskell-ng.compiler;
  haskellngPackages = packagesWithMetaPlatform pkgs.haskellngPackages;

})
// mapHaskellTestOn {

  alex = all;
  async = allBut [ghc6123];
  Cabal = all;
  Cabal_1_18_1_6 = [ghc704 ghc722 ghc742 ghc763 ghc784 ghc7101 ghcHEAD];
  Cabal_1_20_0_3 = [ghc704 ghc722 ghc742 ghc763 ghc784 ghc7101 ghcHEAD];
  Cabal_1_22_1_0 = [ghc722 ghc742 ghc763 ghc784 ghc7101 ghcHEAD];
  cabal2nix = default;
  cabal-install = all;
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
  monad-par = all;
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
  system-fileio = all;
  system-filepath = all;
  tar = all;
  text = all;
  transformers-compat = all;
  transformers = [ghc6123 ghc704 ghc722 ghc742 ghc763];
  unix-time = allBut [ghc6123];
  unordered-containers = allBut [ghc6123];
  vector = all;
  wizards = default;
  wl-pprint = all;
  zlib = all;

}
