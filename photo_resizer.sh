#!/bin/bash

if [ ! -x /usr/bin/convert ]; then
  echo "Chybi soubor /usr/bin/convert"
  echo "Zkus nainstalovat balicek imagemagick"
  exit 1
fi

if [ -e zmensene ]; then
  rm -R zmensene
fi

mkdir zmensene
N=1

for soubor in *.[jJ][pP]* ; do
  A=$N
  while [ ${#A} -lt 3 ]; do
    A="0$A"
  done

  #Fotka
  convert "$soubor" -resize 800x600 -quality 80 zmensene/$A.jpg

  #Náhled
  convert "$soubor" -resize 160x120 -quality 80 zmensene/$A-n.jpg

  N=$(($N+1))
done
