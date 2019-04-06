#!/bin/bash

cat *.md | pandoc -o apuntes_final.pdf --from markdown --template eisvogel --number-sections -F mermaid-filter -V lang=es-ES --pdf-engine xelatex
