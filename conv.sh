#!/bin/bash
for f in `ls *.jpg | grep -v _s`
do
    base=${f%%.*}
		newf=${base}_s.jpg
		echo "Creating $newf from $f"
		convert -size 2548x3504 -resize 1200x1600 $f $newf
done

