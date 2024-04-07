#!/bin/bash

# Get current year and month
CURRENT_YEAR=$(date +%Y)
CURRENT_MONTH=$(date +%m)

# Define source and destination paths
SOURCE_DIR="$HOME/Downloads"
DEST_DIR="$HOME/files.btbytes.com/images/$CURRENT_YEAR/$CURRENT_MONTH"

# Find the latest PNG file if no filename was provided
LATEST_PNG=$(ls -t "$SOURCE_DIR"/* | head -n 1)

echo "File Found: ${LATEST_PNG}. Cancel if this is not what you want. sleep(2)"
sleep 2

# Check if a PNG file was found
if [ -z "$LATEST_PNG" ]; then
    echo "Error: No PNG files found in the Downloads directory."
    exit 1
fi


# Check if a filename was provided as the first argument
if [ $# -gt 0 ]; then
    FILENAME="$1"
else
    # Extract the base filename (without the extension)
    FILENAME="${LATEST_PNG%.*}"
fi

# Create destination directory if needed
echo "Going to create ${DEST_DIR}."

mkdir -p "$DEST_DIR" 

# Convert PNG to WebP (using either the provided FILENAME or the extracted one)
echo "Converting ${LATEST_PNG} to $DEST_DIR/$FILENAME.webp"
cwebp "$LATEST_PNG" -o "$DEST_DIR/$FILENAME.webp"

# Print HTML fragment
echo "<figure>"
echo " <img src=\"https://files.btbytes.com/images/$CURRENT_YEAR/$CURRENT_MONTH/$FILENAME.webp\" alt=\" \">"
echo " <figcaption></figcaption>"
echo "</figure> [via]()"

# Run sync script
(cd "$HOME/files.btbytes.com/" && ./sync.sh)
