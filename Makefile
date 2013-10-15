# Nothing to be done for target 'all'.
all: demo.dvi eksempel.dvi

clean:
	$(RM) -f eksempel.log eksempel.aux eksempel.dvi
	$(RM) -f demo.log demo.aux demo.dvi
	$(RM) -f .#* debian/.#*

tests: ekempel.dvi

eksempel.dvi: eksempel.tex brev.cls
	latex eksempel

demo.dvi: demo.tex brev.cls
	latex demo

giro.dvi: giro.tex giro.cls
	latex giro

debs:
	fakeroot debian/rules binary

PACKAGE = tetex-brev

DESTDIR = /
prefix  = /usr/local
clsdir  = $(DESTDIR)$(prefix)/share/texmf/tex/latex/latex-brev
docdir  = $(DESTDIR)$(prefix)/share/doc/$(PACKAGE)
sitelispdir = $(DESTDIR)$(prefix)/share/emacs/site-lisp

install: eksempel.dvi demo.dvi
	mkdir -p $(clsdir) $(docdir)
	cp brev.cls giro.cls $(clsdir)
	cp brev.el $(sitelispdir)
	cp README eksempel.tex eksempel.dvi demo.tex demo.dvi $(docdir)
