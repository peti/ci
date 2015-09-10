# GNUmakefile

packages := funcmp hackage-db hsyslog largeword shake hledger-interest language-nix nix-paths
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

hackage-db-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/hackage-db.git >$@
	chmod -w $@

language-nix-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/language-nix.git >$@
	chmod -w $@

hsyslog-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/hsyslog.git >$@
	chmod -w $@

shake-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/ndmitchell/shake.git >$@
	chmod -w $@

largeword-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/idontgetoutmuch/largeword.git >$@
	chmod -w $@

nix-paths-pkg.nix:
	rm -f $@
	cabal2nix git://github.com/peti/nix-paths.git >$@
	chmod -w $@

clean::
	rm -f $(nixFiles)
