#!/bin/bash
# Convert PDF to PDF with optimized settings
# Inspired by: https://news.ycombinator.com/item?id=40631901


# Check if the input file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 input.pdf"
  exit 1
fi

# Assign the input file to a variable
INPUT_PDF="$1"

# Convert PDF to PostScript format with specified options
pdftops -paper A4 -expand -level3 "$INPUT_PDF"

# Convert the PostScript file back to PDF with additional options
ps2pdf14 -dEmbedAllFonts=true          \
    -dUseFlateCompression=true         \
    -dOptimize=true                    \
    -dProcessColorModel=/DeviceRGB     \
    -r72                               \
    -dDownsampleGrayImages=true        \
    -dGrayImageResolution=150          \
    -dAutoFilterGrayImages=false       \
    -dGrayImageDownsampleType=/Bicubic \
    -dDownsampleMonoImages=true        \
    -dMonoImageResolution=150          \
    -dMonoImageDownsampleType=/Subsample \
    -dDownsampleColorImages=true       \
    -dColorImageResolution=150         \
    -dAutoFilterColorImages=false      \
    -dColorImageDownsampleType=/Bicubic\
    -dPDFSETTINGS=/ebook               \
    -dNOSAFER                          \
    -dALLOWPSTRANSPARENCY              \
    -dShowAnnots=false                 \
    "${INPUT_PDF%.pdf}.ps" "$INPUT_PDF"

# Clean up the temporary PostScript file
rm "${INPUT_PDF%.pdf}.ps"
