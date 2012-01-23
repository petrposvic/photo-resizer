#!/bin/bash

#Size of new image in pixels
SIZE="800x600"

#Size of preview in pixels
PREVIEW_SIZE="160x120"

#Suffix of preview. Let it empty for no previews.
#PREVIEW_SUFFIX=""
PREVIEW_SUFFIX="-preview"

#Directory where save new images
RESIZED_DIR="resized"

#Length of new name. 0 for the same names.
#RENAME=0
RENAME=3

#Quality
QUALITY=80

#TODO Optional parameters

#-------------------------------------------------------------------------------
#Convert image $1 to image $2 with suffix $3
#-------------------------------------------------------------------------------
function con {
  #Photo
  convert "$1" -resize $SIZE -quality $QUALITY $RESIZED_DIR/$2$3

  #Preview
  if [ ${#PREVIEW_SUFFIX} -gt 0 ]; then
    convert "$1" -resize $PREVIEW_SIZE -quality $QUALITY $RESIZED_DIR/$2$PREVIEW_SUFFIX$3
  fi
}
#-------------------------------------------------------------------------------

if [ ! -x /usr/bin/convert ]; then
  echo "File /usr/bin/convert not found!"
  echo "Try install package: imagemagick"
  exit 1
fi

if [ -e $RESIZED_DIR ]; then
  echo "Directory $RESIZED_DIR already exists! Remove it manualy or use:"
  echo -e "\trm -rf $RESIZED_DIR"
  exit 2
fi

mkdir $RESIZED_DIR

if [ $RENAME -eq 0 ]; then
  for file in *.[jJ][pP]* ; do
    con $file $file
  done
else
  N=1
  for file in *.[jJ][pP]* ; do
    A=$N
    while [ ${#A} -lt $RENAME ]; do
      A="0$A"
    done

    con $file $A .jpg
    N=$(($N+1))
  done
fi
