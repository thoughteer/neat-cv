language ?= english

pdf: ps
	ps2pdf cv.ps

ps: dvi
	dvips cv.dvi

dvi: cv.tex tidycv.cls publications.bib
	echo '\\cvsetlanguage{$(language)}' > language.tex
	latex cv && biber cv && latex cv
	rm language.tex

snapshot: dvi
	gm convert -density 600 cv.dvi +matte -background white -resize 15% -append cv.png

clean:
	rm -f cv.aux cv.bbl cv.bcf cv.blg cv.dvi cv.log cv.out cv.pdf cv.ps cv.run.xml

.PHONY: pdf ps dvi snapshot clean
