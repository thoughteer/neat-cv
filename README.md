# Neat CV

An unsophisticated yet neatly crafted LaTeX class for the [CV](#example).

## License

**Neat CV** is released under the MIT license.

## Requirements

All you need is to install [Docker](https://docs.docker.com/install/).

## Usage

Clone the repo, edit `cv.tex` and `publications.bib` (if any), then run
```bash
$ ./make.sh
```
This will produce `cv.pdf`.

You can change the target language by passing an additional argument as in
```bash
$ ./make.sh language=russian
```
The default language is `english`.

To clean up the directory after compilation, run
```bash
$ ./make.sh clean
```
Note, this will also remove the PDF.

## Customization

#### Color scheme

Just redefine colors in the "Colors" section of the `neatcv.cls` file.

#### Additional LaTeX packages

Add missing Debian packages to the `Dockerfile` file, then run
```bash
docker build -t thoughteer/neat-cv .
```

## Example

![CV](cv.png)
