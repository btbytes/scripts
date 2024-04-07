#!/bin/bash

# Get current year and month
CURRENT_YEAR=$(date +%Y)
CURRENT_MONTH=$(date +%m)

# Define source and destination paths
SOURCE_DIR="$HOME/screenshots"
DEST_DIR="$HOME/files.btbytes.com/images/$CURRENT_YEAR/$CURRENT_MONTH"

# Find the latest PNG file if no filename was provided
LATEST_PNG=$(ls -t "$SOURCE_DIR"/*.png | head -n 1)

# Check if a PNG file was found
if [ -z "$LATEST_PNG" ]; then
    echo "Error: No PNG files found in the screenshots directory."
    exit 1
fi


# Check if a filename was provided as the first argument
if [ $# -gt 0 ]; then
    FILENAME="$1"
else
    # Extract the base filename (without the extension)
    JUSTFILE=$(basename ${LATEST_PNG})
    echo $JUSTFILE
    FILENAME="${JUSTFILE%.*}"
    echo $FILENAME
fi

# Create destination directory if needed
mkdir -p "$DEST_DIR" 

# Convert PNG to WebP (using either the provided FILENAME or the extracted one)
cwebp "$LATEST_PNG" -o "$DEST_DIR/$FILENAME.webp"

# Print HTML fragment
echo "<figure>"
echo " <img src=\"https://files.btbytes.com/images/$CURRENT_YEAR/$CURRENT_MONTH/$FILENAME.webp\" alt=\" \" width=\"600\">"
echo " <figcaption></figcaption>"
echo "</figure> [via]()"

# Run sync script
(cd "$HOME/files.btbytes.com/" && ./sync.sh)
