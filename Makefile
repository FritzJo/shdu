PREFIX ?= /usr/local
DOCDIR ?= $(PREFIX)/share/doc/shdu

all:
	@echo Run \'make install\' to install shdu.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p bashtop $(DESTDIR)$(PREFIX)/bin/shdu
	@mkdir -p $(DESTDIR)$(DOCDIR)
	@cp -p README.md $(DESTDIR)$(DOCDIR)
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/shdu

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/shdu
	@rm -rf $(DESTDIR)$(DOCDIR)
