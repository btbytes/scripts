#!/usr/bin/env bash

# a bash script that takes the given input HEIC file name and removes the exif data and converts it into a .web file with 800px width while maintaining aspect ratio
#
# Check if the required commands are installed
command -v magick >/dev/null 2>&1 || { echo >&2 "ImageMagick is required but not installed. Aborting."; exit 1; }
command -v exiftool >/dev/null 2>&1 || { echo >&2 "exiftool is required but not installed. Aborting."; exit 1; }

# Check if an argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 input_file.HEIC"
    exit 1
fi

# Input filename
input_file=$1

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "File '$input_file' not found."
    exit 1
fi

# Remove EXIF data
exiftool -all= "$input_file"

# Convert HEIC to webp with 800px width while maintaining aspect ratio
magick "$input_file" -resize 2400x\> "${input_file%.HEIC}.webp"

echo "Conversion complete. Output file: ${input_file%.HEIC}.webp"

