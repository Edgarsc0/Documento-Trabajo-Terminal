# Plantilla LaTeX para trabajo académico

Plantilla general derivada de los archivos proporcionados. Es autocontenida,
usa rutas relativas y nombres portables, y puede compilarse en Windows y Ubuntu.

## Inicio rápido

1. Edite los datos en los archivos main.tex y los que están dentro de pretexto.
2. Coloque los logotipos en `figs/` o cambie sus rutas. Si faltan, se
   mostrarán marcadores provisionales y la compilación continuará.
3. Sustituya el contenido de cada .tex en cada carpeta Ch.
4. Agregue las referencias a `Reference/biblio.bib`.

## Compilación recomendada

La opción más estable en ambos sistemas es `latexmk`, porque ejecuta
automáticamente LaTeX y BibTeX las veces necesarias.

### Ubuntu

Instale una distribución razonablemente completa:

```bash
sudo apt update
sudo apt install latexmk texlive-latex-extra texlive-lang-spanish \
  texlive-fonts-recommended texlive-bibtex-extra
```

Compile desde la carpeta de la plantilla:

```bash
chmod +x compilar.sh limpiar.sh
./compilar.sh
```

### Windows

Instale MiKTeX o TeX Live y habilite la instalación automática de paquetes.
Abra PowerShell o la consola en la carpeta de la plantilla y ejecute:

```bat
compilar.bat
```

En TeXstudio o TeXworks, establezca `main.tex` como documento maestro. Puede
usar directamente `latexmk -pdf main.tex` como orden de compilación.

## Alternativa manual

Si `latexmk` no está disponible, ejecute:

```text
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

## LuaLaTeX

La configuración también admite LuaLaTeX. Para usarlo sin modificar
`latexmkrc`, ejecute:

```text
latexmk -lualatex -outdir=build main.tex
```

## Reglas de portabilidad

- Conserve la misma combinación de mayúsculas y minúsculas en nombres y rutas.
- Evite espacios, acentos y caracteres especiales en nombres de archivos.
- Use `/` en las rutas escritas dentro de LaTeX, incluso en Windows.
- No escriba rutas absolutas como `C:\...` o `/home/...`.
- Prefiera PDF o PNG para logotipos y figuras; JPG es adecuado para fotografías.
- Guarde todos los archivos de texto como UTF-8.
- No use el paquete obsoleto `times`; esta plantilla elige una fuente portable
  según el motor de compilación.

## Estructura

```text
── bachelorstitlepageUNAM.sty
├── Ch1
│   ├── ch1.aux
│   └── ch1.tex
├── Ch2
│   ├── ch2.aux
│   └── ch2.tex
├── Ch3
│   ├── ch3.aux
│   └── ch3.tex
├── Ch4
│   ├── ch4.aux
│   └── ch4.tex
├── Ch5
│   ├── ch5.aux
│   └── ch5.tex
├── Ch6
│   ├── ch6.aux
│   └── ch6.tex
├── Ch7
│   ├── ch7.aux
│   └── ch7.tex
├── Ch8
│   ├── ch8.aux
│   └── ch8.tex
├── Ch9
│   ├── ch9.aux
│   └── ch9.tex
├── compilar.bat
├── compilar.sh
├── figs
│   └── README.txt
├── Images
│   ├── ESCOM.png
│   └── logo-ipn.png
├── latexmkrc
├── limpiar.bat
├── limpiar.sh
├── main.bbl
├── main.pdf
├── main.synctex.gz
├── main.tex
├── NOTAS-DE-REVISION.md
├── Pretexto
│   ├── Abreviaturas.aux
│   ├── Abreviaturas.tex
│   ├── abstract.aux
│   ├── abstract.tex
│   ├── Advertencia.aux
│   ├── Advertencia.tex
│   ├── frontmater.aux
│   ├── frontmater.tex
│   ├── Glosario.aux
│   ├── Glosario.tex
│   ├── portada.aux
│   └── portada.tex
├── README.md
└── References
    └── biblio.bib

```
