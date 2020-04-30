#!/bin/bash

pandoc $1 -o $1.pdf --from markdown --template eisvogel --number-sections -F mermaid-filter -V lang=es-ES --latex-engine xelatex
