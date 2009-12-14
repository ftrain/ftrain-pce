SHELL := /bin/bash
PERL=/usr/bin/perl
SIMPDFTEX=simpdftex latex --maxpfb
#PDFLATEX=pdflatex
#PDFLATEX=/usr/local/texlive/2008/bin/universal-darwin/pdflatex
PDFLATEX=/opt/local/bin/pdflatex
PANDOC=pandoc
MARKDOWN_BOOK=book.md
TEMP_OUTPUT=parsedbook.md
WIDE=wide
FINAL=final
READING=reading
DRAFT=draft


all: final draft wide html

preparse:
	cp $(MARKDOWN_BOOK) $(TEMP_OUTPUT)
	$(PERL) bin/vars.pl $(TEMP_OUTPUT)

preparse-latex: preparse
	$(PERL) bin/to_latex.pl $(TEMP_OUTPUT)

preparse-html: preparse
	$(PERL) bin/to_html.pl $(TEMP_OUTPUT)

preparse-rtf: preparse
	$(PERL) bin/to_rtf.pl $(TEMP_OUTPUT)

draft: preparse-latex
	$(PANDOC) --no-wrap -S -f markdown -s -C"lib/headers/$(DRAFT).tex" -o latex $(TEMP_OUTPUT) -o $(DRAFT).tex
	$(PERL) bin/to_final.pl $(DRAFT).tex
	$(PERL) bin/to_latex.pl $(DRAFT).tex
	$(PERL) bin/endumbifyquotes.pl $(DRAFT).tex
	$(SIMPDFTEX) $(DRAFT).tex

final: preparse-latex
	$(PANDOC) --no-wrap -S -f markdown -s -C"lib/headers/$(FINAL).tex" -o latex $(TEMP_OUTPUT) -o $(FINAL).tex
	$(PERL) bin/to_final.pl $(FINAL).tex
	$(PERL) bin/to_latex.pl $(FINAL).tex
	$(PDFLATEX) $(FINAL).tex

wide: preparse-latex
	$(PANDOC) --no-wrap -S -f markdown -s -C"lib/headers/$(WIDE).tex" -o latex $(TEMP_OUTPUT) -o $(WIDE).tex
	$(PERL) bin/to_final.pl $(WIDE).tex
	$(PERL) bin/to_latex.pl $(WIDE).tex
	$(PDFLATEX) $(WIDE).tex

reading: preparse-latex
	$(PERL) bin/wcfn.pl $(TEMP_OUTPUT) > post_wordcount.tmp
	mv post_wordcount.tmp $(TEMP_OUTPUT)
	$(PANDOC) --no-wrap -S -f markdown -s -C"lib/headers/$(READING).tex" -o latex $(TEMP_OUTPUT) -o $(READING).tex
	$(PERL) bin/to_final.pl $(READING).tex
	$(PERL) bin/to_latex_reading.pl $(READING).tex
	$(PDFLATEX) $(READING).tex

odt: preparse-rtf 
	$(PANDOC) --no-wrap -f markdown -s -t odt -S -o out.odt $(TEMP_OUTPUT)

rtf: preparse-rtf 
	$(PANDOC) --no-wrap -f markdown -C"lib/headers/header.rtf" -s -t rtf -S -o book.rtf $(TEMP_OUTPUT)
	$(PERL) bin/post_rtf.pl book.rtf

html: preparse-html 
	$(PANDOC) --no-wrap -f markdown -s -t html -c "css/novel.css" -S --toc -o book.html $(TEMP_OUTPUT)

man: preparse
	$(PANDOC) --no-wrap -f markdown -s -t man -S -o novel.1 book.md
	groff -Tps -man novel.1|ps2pdf - novel_groff.pdf
#	man -M$MATHPATH:$PWD ./novel.1	


clean:
	@rm -f  *.aux \
		*.dvi \
		*.groff \
		*.html \
		*.idx \
		*.ind \
		*.log \
		*.odt \
		*.out \
		*.pdf \
		*.ps \
		*.rtf \
		*.toc \
		*~ \
		*.tex \
		draft.* \
		final.* \
		novel.1 \
		$(TEMP_OUTPUT)
