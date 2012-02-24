#!/bin/bash
# Usage: ./combinepdf.sh `ls -1` to combine all the pdfs in curdir into combine.pdf
# source: http://www.debianadmin.com/combine-multiple-pdfs-into-one-file-in-ubuntu-linux.html
# 2012-02-24

gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=combined.pdf -dBATCH $@
