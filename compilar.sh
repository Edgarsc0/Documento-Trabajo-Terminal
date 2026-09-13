#!/usr/bin/env sh

set -eu

cd "$(dirname "$0")"

# Compilar
latexmk -norc -pdf \
  -synctex=1 \
  -interaction=nonstopmode \
  -file-line-error \
  main.tex

# Verificar que el PDF se generó correctamente
if [ -f "main.pdf" ]; then
    printf '%s\n' 'Compilación correcta: main.pdf generado.'

    printf '%s\n' 'Limpiando archivos auxiliares...'

    # Eliminar auxiliares sin borrar el PDF final
    find . -type f \( \
        -name '*.aux' -o \
        -name '*.bbl' -o \
        -name '*.bcf' -o \
        -name '*.blg' -o \
        -name '*.fdb_latexmk' -o \
        -name '*.fls' -o \
        -name '*.log' -o \
        -name '*.out' -o \
        -name '*.run.xml' -o \
        -name '*.toc' -o \
        -name '*.lof' -o \
        -name '*.lot' -o \
        -name '*.synctex.gz' \
    \) -delete
    
    printf '%s\n' 'Archivos auxiliares eliminados.'
    printf '%s\n' 'Documento final: main.pdf'
else
    printf '%s\n' 'ERROR: no se generó main.pdf.' >&2
    exit 1
fi