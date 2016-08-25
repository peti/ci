/* Essential system packages that must build. */

{ supportedSystems ? [ "x86_64-linux" ] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

mapTestOn {

  androidenv.platformTools = supportedSystems;
  anki = supportedSystems;
  antiword = supportedSystems;
  asciidoc = supportedSystems;
  aspell = supportedSystems;
  aspellDicts.de = supportedSystems;
  aspellDicts.en = supportedSystems;
  asymptote = supportedSystems;
  autoconf = supportedSystems;
  automake = supportedSystems;
  automake114x = supportedSystems;
  awscli = supportedSystems;
  banner = supportedSystems;
  bc = supportedSystems;
  bison = supportedSystems;
  blender = supportedSystems;
  cabal2nix = supportedSystems;
  celestia = supportedSystems;
  curl = supportedSystems;
  cvs = supportedSystems;
  cvsps = supportedSystems;
  darcs = supportedSystems;
  dash = supportedSystems;
  davfs2 = supportedSystems;
  dia = supportedSystems;
  dmenu = supportedSystems;
  docbook2x = supportedSystems;
  docbook_xml_dtd_45 = supportedSystems;
  docbook_xml_xslt = supportedSystems;
  doxygen = supportedSystems;
  duplicity = supportedSystems;
  emacs = supportedSystems;
  eukleides = supportedSystems;
  expat = supportedSystems;
  fetchmail = supportedSystems;
  ffmpeg = supportedSystems;
  file = supportedSystems;
  firefox = supportedSystems;
  flex = supportedSystems;
  gcc = supportedSystems;
  gdb = supportedSystems;
  gettext = supportedSystems;
  ghostscript = supportedSystems;
  ghostscriptX = supportedSystems;
  gitAndTools.git-annex = supportedSystems;
  gitFull = supportedSystems;
  glxinfo = supportedSystems;
  gmpxx = supportedSystems;
  gmrun = supportedSystems;
  gnome.GConf = supportedSystems;
  gnucash = supportedSystems;
  gnum4 = supportedSystems;
  gnumake = supportedSystems;
  gnupg1compat = supportedSystems;
  gnuplot = supportedSystems;
  gnutls = supportedSystems;
  gparted = supportedSystems;
  gprolog = supportedSystems;
  graphviz = supportedSystems;
  grip = supportedSystems;
  gv = supportedSystems;
  hardlink = supportedSystems;
  htmlTidy = supportedSystems;
  htop = supportedSystems;
  id3v2 = supportedSystems;
  ikiwiki = supportedSystems;
  imagemagick = supportedSystems;
  imlib2 = supportedSystems;
  lame = supportedSystems;
  ledger = supportedSystems;
  ledger2 = supportedSystems;
  libtool = supportedSystems;
  libxml2 = supportedSystems;
  libxslt = supportedSystems;
  lzip = supportedSystems;
  manpages = supportedSystems;
  maude = supportedSystems;
  maxima = supportedSystems;
  mercurialFull = supportedSystems;
  mesa_noglu = supportedSystems;
  miniHttpd = supportedSystems;
  mpack = supportedSystems;
  mpfr = supportedSystems;
  mpg123 = supportedSystems;
  mplayer = supportedSystems;
  mpv = supportedSystems;
  nbd = supportedSystems;
  ncftp = supportedSystems;
  ncurses = supportedSystems;
  nix-repl = supportedSystems;
  nixopsUnstable = supportedSystems;
  nixpkgs-lint = supportedSystems;
  openjdk = supportedSystems;
  openssl = supportedSystems;
  p7zip = supportedSystems;
  patchelf = supportedSystems;
  pdsh = supportedSystems;
  perlPackages.DigestSHA1 = supportedSystems;
  pmutils = supportedSystems;
  posix_man_pages = supportedSystems;
  postfix = supportedSystems;
  procmail = supportedSystems;
  python = supportedSystems;
  python3 = supportedSystems;
  qemu = supportedSystems;
  rcs = supportedSystems;
  redis = supportedSystems;
  rPackages.assertthat = supportedSystems;
  rPackages.BerlinData = supportedSystems;
  rPackages.data_table = supportedSystems;
  rPackages.digest = supportedSystems;
  rPackages.doParallel = supportedSystems;
  rPackages.foreach = supportedSystems;
  rPackages.lintr = supportedSystems;
  rPackages.memoise = supportedSystems;
  rPackages.plan = supportedSystems;
  rPackages.RSQLite = supportedSystems;
  rPackages.xtable = supportedSystems;
  rtorrent = supportedSystems;
  rWrapper = supportedSystems;
  saneBackends = supportedSystems;
  scons = supportedSystems;
  simplescreenrecorder = supportedSystems;
  sqliteInteractive = supportedSystems;
  stellarium = supportedSystems;
  subversion = supportedSystems;
  telnet = supportedSystems;
  texlive.combined.scheme-full = supportedSystems;
  tightvnc = supportedSystems;
  tree = supportedSystems;
  unetbootin = supportedSystems;
  utillinuxCurses = supportedSystems;
  wdiff = supportedSystems;
  wget = supportedSystems;
  which = supportedSystems;
  wxmaxima = supportedSystems;
  xautolock = supportedSystems;
  xdg_utils = supportedSystems;
  xfig = supportedSystems;
  xlibs.xauth = supportedSystems;
  xlibs.xbacklight = supportedSystems;
  xlibs.xev = supportedSystems;
  xlibs.xf86inputsynaptics = supportedSystems;
  xlibs.xf86videointel = supportedSystems;
  xlibs.xmessage = supportedSystems;
  xlibs.xmodmap = supportedSystems;
  xlibs.xwininfo = supportedSystems;
  xlsfonts = supportedSystems;
  xmlto = supportedSystems;
  xpdf = supportedSystems;
  xsane = supportedSystems;
  xterm = supportedSystems;
  xxdiff = supportedSystems;
  youtube-dl = supportedSystems;
  zlib = supportedSystems;

}
