LATEX = latex --output-comment=""
PDFLATEX = pdflatex --output-comment=""

# Nothing to be done for target 'all'.
all: demo.dvi eksempel.dvi

clean:
	$(RM) -f eksempel.log eksempel.aux eksempel.dvi eksempel.pdf
	$(RM) -f demo.log demo.aux demo.dvi demo.pdf
	$(RM) -f giro.aux giro.log giro.dvi giro.pdf
	$(RM) -f .#* debian/.#*

tests: eksempel.dvi

eksempel.dvi: eksempel.tex brev.cls
	$(LATEX) eksempel
eksempel.pdf: eksempel.tex brev.cls
	$(PDFLATEX) eksempel

demo.dvi: demo.tex brev.cls
	$(LATEX) demo
demo.pdf: demo.tex brev.cls
	$(PDFLATEX) demo

giro.dvi: giro.tex giro.cls
	$(LATEX) giro
giro.pdf: giro.tex giro.cls
	$(PDFLATEX) giro

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
