#!/bin/sh

docker run --rm -v $(pwd):/neat-cv thoughteer/neat-cv "$@"
