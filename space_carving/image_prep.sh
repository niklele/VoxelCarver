#!/bin/sh

# Run from space_carving eg ./image_prep.sh bluecup

new_dir=$1_prepped
mkdir -p $new_dir
cd $1

pwd

i=1
for f in *.jpg
do
  echo $f ' -> ' $i.jpg

  # imagemagick cropping
  convert $f -resize 1024x1024^ -gravity center -extent 1024x1024 ../$new_dir/$i.jpg
  let "i++"
done
