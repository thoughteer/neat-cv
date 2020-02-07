FROM debian:stretch

WORKDIR /neat-cv

RUN apt-get clean \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        biber \
        build-essential \
        ghostscript \
        graphicsmagick \
        texlive \
        texlive-bibtex-extra \
        texlive-fonts-extra \
        texlive-lang-cyrillic \
        texlive-latex-extra

ADD Makefile /neat-cv

ENTRYPOINT ["make"]
