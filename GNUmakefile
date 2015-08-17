# GNUmakefile

packages := funcmp hackage-db hsyslog largeword shake hledger-interest
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

clean::
	rm -f $(nixFiles)
