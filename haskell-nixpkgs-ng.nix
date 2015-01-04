/* Essential Haskell packages in Nixpkgs that must build. */

{ supportedSystems ? [ "x86_64-linux" ], big ? false }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

mapTestOn (if big then {

  # cryptol2 = supportedSystems;
  # darcs = supportedSystems;
  # jhc = supportedSystems;
  pandoc = supportedSystems;

  ghc6101Binary = supportedSystems;
  ghc6102Binary = supportedSystems;
  ghc6121Binary = supportedSystems;
  ghc642Binary = supportedSystems;
  ghc704Binary = supportedSystems;
  ghc742Binary = supportedSystems;

  ghc6104 = supportedSystems;
  ghc6123 = supportedSystems;
  ghc704 = supportedSystems;
  ghc722 = supportedSystems;
  ghc741 = supportedSystems;
  ghc742 = supportedSystems;
  ghc761 = supportedSystems;
  ghc762 = supportedSystems;
  ghc763 = supportedSystems;
  ghc783 = supportedSystems;
  ghc784 = supportedSystems;
  ghcHEAD = supportedSystems;
  ghc = supportedSystems;

  haskellPackages = packagesWithMetaPlatform pkgs.haskellPackages;

} else {

  haskellPackages = {

    aeson-qq = supportedSystems;
    aeson = supportedSystems;
    alex = supportedSystems;
    appar = supportedSystems;
    asn1-encoding = supportedSystems;
    asn1-parse = supportedSystems;
    asn1-types = supportedSystems;
    async = supportedSystems;
    attoparsec = supportedSystems;
    authenticate = supportedSystems;
    auto-update = supportedSystems;
    aws = supportedSystems;
    base16-bytestring = supportedSystems;
    base64-bytestring = supportedSystems;
    base-compat = supportedSystems;
    bifunctors = supportedSystems;
    blaze-builder = supportedSystems;
    blaze-html = supportedSystems;
    blaze-markup = supportedSystems;
    bloomfilter = supportedSystems;
    byteable = supportedSystems;
    byteorder = supportedSystems;
    cabal2nix = supportedSystems;
    cabal-install = supportedSystems;
    case-insensitive = supportedSystems;
    cereal = supportedSystems;
    chell = supportedSystems;
    cipher-aes = supportedSystems;
    cipher-des = supportedSystems;
    cipher-rc4 = supportedSystems;
    clientsession = supportedSystems;
    cmdargs = supportedSystems;
    cmdlib = supportedSystems;
    comonad = supportedSystems;
    conduit-extra = supportedSystems;
    conduit = supportedSystems;
    connection = supportedSystems;
    contravariant = supportedSystems;
    cookie = supportedSystems;
    cpphs = supportedSystems;
    cprng-aes = supportedSystems;
    crypto-api = supportedSystems;
    crypto-cipher-tests = supportedSystems;
    crypto-cipher-types = supportedSystems;
    cryptohash-conduit = supportedSystems;
    cryptohash = supportedSystems;
    crypto-numbers = supportedSystems;
    crypto-pubkey = supportedSystems;
    crypto-pubkey-types = supportedSystems;
    crypto-random = supportedSystems;
    css-text = supportedSystems;
    curl = supportedSystems;
    data-default-class = supportedSystems;
    data-default-instances-base = supportedSystems;
    data-default-instances-containers = supportedSystems;
    data-default-instances-dlist = supportedSystems;
    data-default-instances-old-locale = supportedSystems;
    data-default = supportedSystems;
    dataenc = supportedSystems;
    data-memocombinators = supportedSystems;
    DAV = supportedSystems;
    dbus = supportedSystems;
    deepseq-generics = supportedSystems;
    Diff = supportedSystems;
    digest = supportedSystems;
    distributive = supportedSystems;
    dlist = supportedSystems;
    dns = supportedSystems;
    doctest = supportedSystems;
    easy-file = supportedSystems;
    edit-distance = supportedSystems;
    either = supportedSystems;
    email-validate = supportedSystems;
    enclosed-exceptions = supportedSystems;
    entropy = supportedSystems;
    errorcall-eq-instance = supportedSystems;
    errors = supportedSystems;
    exceptions = supportedSystems;
    extensible-exceptions = supportedSystems;
    extra = supportedSystems;
    fast-logger = supportedSystems;
    fdo-notify = supportedSystems;
    feed = supportedSystems;
    fgl = supportedSystems;
    file-embed = supportedSystems;
    fingertree = supportedSystems;
    free = supportedSystems;
    funcmp = supportedSystems;
    generic-deriving = supportedSystems;
    ghcjs-prim = supportedSystems;
    ghcjs = supportedSystems;
    ghc-paths = supportedSystems;
    ghc = supportedSystems;
    git-annex = supportedSystems;
    GLUT = supportedSystems;
    gnuidn = supportedSystems;
    gnutls = supportedSystems;
    gsasl = supportedSystems;
    hackage-db = supportedSystems;
    haddock-library = supportedSystems;
    haddock = supportedSystems;
    hamlet = supportedSystems;
    happy = supportedSystems;
    hashable = supportedSystems;
    hashtables = supportedSystems;
    haskell-src-exts = supportedSystems;
    haskell-src-meta = supportedSystems;
    haskell-src = supportedSystems;
    highlighting-kate = supportedSystems;
    hinotify = supportedSystems;
    hjsmin = supportedSystems;
    hlint = supportedSystems;
    hopenssl = supportedSystems;
    hourglass = supportedSystems;
    hscolour = supportedSystems;
    hsdns = supportedSystems;
    hsemail = supportedSystems;
    hslogger = supportedSystems;
    hslua = supportedSystems;
    hspec-core = supportedSystems;
    hspec-discover = supportedSystems;
    hspec-expectations = supportedSystems;
    hspec-meta = supportedSystems;
    hspec = supportedSystems;
    hsyslog = supportedSystems;
    html = supportedSystems;
    http-client = supportedSystems;
    http-client-tls = supportedSystems;
    http-conduit = supportedSystems;
    http-date = supportedSystems;
    HTTP = supportedSystems;
    http-types = supportedSystems;
    HUnit = supportedSystems;
    idna = supportedSystems;
    IfElse = supportedSystems;
    iproute = supportedSystems;
    jailbreak-cabal = supportedSystems;
    json = supportedSystems;
    JuicyPixels = supportedSystems;
    keys = supportedSystems;
    language-c = supportedSystems;
    language-haskell-extract = supportedSystems;
    language-javascript = supportedSystems;
    lens = supportedSystems;
    libxml-sax = supportedSystems;
    lifted-async = supportedSystems;
    lifted-base = supportedSystems;
    logict = supportedSystems;
    mime-mail = supportedSystems;
    mime-types = supportedSystems;
    MissingH = supportedSystems;
    mmorph = supportedSystems;
    monad-control = supportedSystems;
    monad-logger = supportedSystems;
    monad-loops = supportedSystems;
    monad-par = supportedSystems;
    MonadRandom = supportedSystems;
    monads-tf = supportedSystems;
    mtl = supportedSystems;
    mwc-random = supportedSystems;
    nanospec = supportedSystems;
    nats = supportedSystems;
    network-info = supportedSystems;
    network-multicast = supportedSystems;
    network-protocol-xmpp = supportedSystems;
    network = supportedSystems;
    network-uri = supportedSystems;
    OpenGL = supportedSystems;
    options = supportedSystems;
    optparse-applicative = supportedSystems;
    pandoc = supportedSystems;
    pandoc-types = supportedSystems;
    parallel = supportedSystems;
    parsec = supportedSystems;
    path-pieces = supportedSystems;
    patience = supportedSystems;
    pcre-light = supportedSystems;
    pem = supportedSystems;
    permutation = supportedSystems;
    persistent-sqlite = supportedSystems;
    persistent = supportedSystems;
    persistent-template = supportedSystems;
    pointed = supportedSystems;
    polyparse = supportedSystems;
    prelude-extras = supportedSystems;
    primitive = supportedSystems;
    profunctors = supportedSystems;
    publicsuffixlist = supportedSystems;
    punycode = supportedSystems;
    quickcheck-instances = supportedSystems;
    quickcheck-io = supportedSystems;
    QuickCheck = supportedSystems;
    reducers = supportedSystems;
    reflection = supportedSystems;
    regex-base = supportedSystems;
    regex-compat = supportedSystems;
    regex-pcre = supportedSystems;
    regex-posix = supportedSystems;
    regex-tdfa-rc = supportedSystems;
    regex-tdfa = supportedSystems;
    resource-pool = supportedSystems;
    resourcet = supportedSystems;
    SafeSemaphore = supportedSystems;
    safe = supportedSystems;
    scientific = supportedSystems;
    securemem = supportedSystems;
    semigroupoids = supportedSystems;
    semigroups = supportedSystems;
    setenv = supportedSystems;
    shakespeare = supportedSystems;
    SHA = supportedSystems;
    shelly = supportedSystems;
    silently = supportedSystems;
    simple-reflect = supportedSystems;
    simple-sendfile = supportedSystems;
    skein = supportedSystems;
    smallcheck = supportedSystems;
    socks = supportedSystems;
    split = supportedSystems;
    stm-chans = supportedSystems;
    stm = supportedSystems;
    streaming-commons = supportedSystems;
    streamproc = supportedSystems;
    stringprep = supportedSystems;
    stringsearch = supportedSystems;
    syb = supportedSystems;
    system-fileio = supportedSystems;
    system-filepath = supportedSystems;
    tagged = supportedSystems;
    tagsoup = supportedSystems;
    tagstream-conduit = supportedSystems;
    tar = supportedSystems;
    tasty-ant-xml = supportedSystems;
    tasty-hunit = supportedSystems;
    tasty-quickcheck = supportedSystems;
    tasty-rerun = supportedSystems;
    tasty-smallcheck = supportedSystems;
    tasty = supportedSystems;
    tasty-th = supportedSystems;
    temporary = supportedSystems;
    terminfo = supportedSystems;
    test-framework-hunit = supportedSystems;
    test-framework-quickcheck2 = supportedSystems;
    test-framework-th = supportedSystems;
    texmath = supportedSystems;
    text-binary = supportedSystems;
    text-icu = supportedSystems;
    text = supportedSystems;
    th-expand-syns = supportedSystems;
    th-lift = supportedSystems;
    th-orphans = supportedSystems;
    th-reify-many = supportedSystems;
    tls = supportedSystems;
    transformers-base = supportedSystems;
    transformers-compat = supportedSystems;
    unbounded-delays = supportedSystems;
    uniplate = supportedSystems;
    unix-compat = supportedSystems;
    unix-time = supportedSystems;
    unordered-containers = supportedSystems;
    utf8-light = supportedSystems;
    utf8-string = supportedSystems;
    uuid = supportedSystems;
    vault = supportedSystems;
    vector = supportedSystems;
    void = supportedSystems;
    wai-app-static = supportedSystems;
    wai-extra = supportedSystems;
    wai-logger = supportedSystems;
    wai = supportedSystems;
    warp = supportedSystems;
    warp-tls = supportedSystems;
    wl-pprint = supportedSystems;
    wl-pprint-text = supportedSystems;
    word8 = supportedSystems;
    x509-store = supportedSystems;
    x509 = supportedSystems;
    x509-system = supportedSystems;
    x509-validation = supportedSystems;
    xml-conduit = supportedSystems;
    xml-hamlet = supportedSystems;
    xml-types = supportedSystems;
    xss-sanitize = supportedSystems;
    yaml = supportedSystems;
    yesod-auth = supportedSystems;
    yesod-core = supportedSystems;
    yesod-default = supportedSystems;
    yesod-form = supportedSystems;
    yesod-persistent = supportedSystems;
    yesod-static = supportedSystems;
    yesod = supportedSystems;
    zip-archive = supportedSystems;
    zlib = supportedSystems;

  };

})
