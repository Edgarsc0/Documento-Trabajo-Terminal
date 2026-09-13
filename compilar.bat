@echo off
setlocal

REM Ir a la carpeta donde está este script
cd /d "%~dp0"

REM ============================
REM         COMPILAR
REM ============================

latexmk -norc -pdf ^
  -synctex=1 ^
  -interaction=nonstopmode ^
  -file-line-error ^
  main.tex

REM Si latexmk terminó con error, salir
if errorlevel 1 (
    echo ERROR: La compilacion fallo.
    exit /b 1
)

REM ============================
REM     VERIFICAR EL PDF
REM ============================

if exist "main.pdf" (
    echo Compilacion correcta: main.pdf generado.
    echo Limpiando archivos auxiliares...

    REM ============================
    REM      LIMPIAR AUXILIARES
    REM ============================

    for /r %%F in (*.aux) do del /q "%%F"
    for /r %%F in (*.bbl) do del /q "%%F"
    for /r %%F in (*.bcf) do del /q "%%F"
    for /r %%F in (*.blg) do del /q "%%F"
    for /r %%F in (*.fdb_latexmk) do del /q "%%F"
    for /r %%F in (*.fls) do del /q "%%F"
    for /r %%F in (*.log) do del /q "%%F"
    for /r %%F in (*.out) do del /q "%%F"
    for /r %%F in (*.run.xml) do del /q "%%F"
    for /r %%F in (*.toc) do del /q "%%F"
    for /r %%F in (*.lof) do del /q "%%F"
    for /r %%F in (*.lot) do del /q "%%F"
    for /r %%F in (*.synctex.gz) do del /q "%%F"

    echo Archivos auxiliares eliminados.
    echo Documento final: main.pdf
) else (
    echo ERROR: no se genero main.pdf.
    exit /b 1
)

endlocal