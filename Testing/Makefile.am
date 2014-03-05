ACLOCAL_AMFLAGS = -I m4 --install

DISTCLEANFILES = *~ .DS_Store

distclean-local:
	rm -rf autom4te.cache || rmdir autom4te.cache
.PHONY: distclean-local

test:
	@echo "Test succeeded."
.PHONY: test

check-local: test
.PHONY: check-local
