#!/bin/bash
set -xeu 

# Check if the second argument (FILENAME) is provided, or use the original filename.
if [ -z "$2" ]; then
  FILENAME="$(basename "$1")"
else
  FILENAME="$2"
fi

# Get the current year and month.
YYYY=$(date +'%Y')
MM=$(date +'%m')


# Define the output directory path.
OUTPUT_DIR="/Users/pradeep/files.btbytes.com/pictures/$YYYY/$MM/"

# Create the output directory if it doesn't exist.
mkdir -p "${OUTPUT_DIR}"

# Convert the HEIC file to webp format
convert "$(pwd)/$1" -quality 1 "${OUTPUT_DIR}${FILENAME}.webp"

# Create a thumbnail (max 600px width while maintaining aspect ratio).
convert -resize 600x -quality 1 "$(pwd)/$1" "${OUTPUT_DIR}${FILENAME}_thumb.webp"

# Print the output paths.
echo "${OUTPUT_DIR}${FILENAME}.webp"
echo "${OUTPUT_DIR}${FILENAME}_thumb.webp"

# Print the web URLs.
echo "https://files.btbytes.com/pictures/${YYYY}/${MM}/${FILENAME}.webp"
echo "https://files.btbytes.com/pictures/${YYYY}/${MM}/${FILENAME}_thumb.webp"

# Print the HTML code for embedding the thumbnail.
echo "<a href=\"https://files.btbytes.com/pictures/${YYYY}/${MM}/${FILENAME}.webp\"><img src=\"https://files.btbytes.com/pictures/${YYYY}/${MM}/${FILENAME}_thumb.webp\" alt=\"thumbnail\" /></a>"

