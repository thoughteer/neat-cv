language ?= english

cv.pdf: cv.ps
	ps2pdf $^

cv.ps: cv.dvi
	dvips $^

cv.dvi: cv.tex tidycv.cls publications.bib
	echo '\\cvsetlanguage{$(language)}' > language.tex
	latex cv && biber cv && latex cv
	rm language.tex

snapshot: cv.dvi
	convert -density 300 $^ -background white -alpha remove -resize 25% -append cv.png

clean:
	rm -f cv.aux cv.bbl cv.bcf cv.blg cv.dvi cv.log cv.out cv.pdf cv.ps cv.run.xml

.PHONY: snapshot clean
