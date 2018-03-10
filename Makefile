language ?= english

cv: cv.ps
	ps2pdf $^ && mv cv.pdf artifacts/

cv.ps: cv.dvi
	dvips $^

cv.dvi: cv.tex tidycv.cls publications.bib
	echo '\\cvsetlanguage{$(language)}' > language.tex
	latex cv && biber cv && latex cv
	rm language.tex

snapshot: cv.dvi
	gm convert -density 600 $^ +matte -background white -resize 15% -append artifacts/cv.png

.PHONY: cv snapshot
