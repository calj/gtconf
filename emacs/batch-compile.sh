#! /usr/bin/env sh

echo "(setq load-path (cons \".\" load-path))" > script
emacs -batch -q -l script -f batch-byte-compile *.el .emacs_x .emacs_nox
rm -rf script
