#!/bin/bash

function makeimg {
  pdflatex $1.tex

  inkscape --without-gui \
    --file=$1.pdf --export-plain-svg=$1.svg

  inkscape --verb=FitCanvasToDrawing \
    --verb=FileSave --verb=FileClose --verb=FileQuit \
    $1.svg

  convert -density 150 $1.svg $1.png
}

makeimg graph1
makeimg graph2

