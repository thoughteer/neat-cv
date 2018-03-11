# Tidy CV

An unsophisticated yet neatly crafted LaTeX class for the [CV](#example).

## License

**Tidy CV** is released under the MIT license.

## Requirements

All you need is to install [Docker](https://docs.docker.com/install/).

## Usage

Clone the repo, edit `cv.tex` and `publications.bib` (if any), then run
```bash
docker run -v $(pwd):/tidy-cv thoughteer/tidy-cv
```
This will produce `cv.pdf`.

You can change the target language by passing an additional argument as in
```bash
docker run -v $(pwd):/tidy-cv thoughteer/tidy-cv language=russian
```
The default language is `english`.

To clean up the directory after compilation, run
```bash
docker run -v $(pwd):/tidy-cv thoughteer/tidy-cv clean
```
Note, this will also remove the PDF.

## Customization

#### Color scheme

Just redefine colors in the "Colors" section of the `tidycv.cls` file.

#### Additional LaTeX packages

Add missing Debian packages to the `Dockerfile` file, then run
```bash
docker build -t tidy-cv .
```

## Example

![CV](cv.png)
