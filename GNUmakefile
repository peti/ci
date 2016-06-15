# GNUmakefile

packages := funcmp hackage-db hsyslog hledger-interest language-nix nix-paths hsdns
packages += distribution-nixpkgs cabal2nix
nixFiles := $(foreach pkg,$(packages),$(pkg)-pkg.nix)

all:	$(nixFiles)

funcmp-pkg.nix:
	rm -f $@
	cabal2nix http://git.savannah.gnu.org/r/funcmp.git >$@
	chmod -w $@

hledger-interest-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/hledger-interest.git >$@
	chmod -w $@

cabal2nix-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/NixOS/cabal2nix.git >$@
	chmod -w $@

hackage-db-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/hackage-db.git >$@
	chmod -w $@

language-nix-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/language-nix.git >$@
	chmod -w $@

distribution-nixpkgs-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/distribution-nixpkgs.git >$@
	chmod -w $@

hsyslog-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/hsyslog.git >$@
	chmod -w $@

nix-paths-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/nix-paths.git >$@
	chmod -w $@

hsdns-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/hsdns.git >$@
	chmod -w $@

clean::
	rm -f $(nixFiles)
