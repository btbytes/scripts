#!/usr/bin/env python
import os
import sys
import subprocess
from pathlib import Path

def check_command(command):
    """Check if a command is available."""
    return subprocess.call(["which", command], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) == 0

def convert_heic_to_webp(input_file, quality=80):
    """Convert a single HEIC file to WebP."""
    input_path = Path(input_file)
    if not input_path.exists():
        print(f"File not found: {input_file}")
        return

    output_file = input_path.with_suffix('.webp')
    temp_png = input_path.with_stem(input_path.stem + '_temp').with_suffix('.png')

    try:
        # Convert HEIC to PNG (temporary file)
        subprocess.run(['heif-convert', str(input_path), str(temp_png)], check=True)

        # Convert PNG to WebP
        subprocess.run(['cwebp', '-q', str(quality), str(temp_png), '-o', str(output_file)], check=True)

        print(f"Converted {input_path.name} to {output_file.name}")
    except subprocess.CalledProcessError as e:
        print(f"Error converting {input_path.name}: {e}")
    finally:
        # Remove temporary PNG file
        if temp_png.exists():
            temp_png.unlink()

def main():
    # Check if required commands are installed
    if not check_command('heif-convert'):
        print("heif-convert could not be found. Please install libheif-examples.")
        sys.exit(1)
    if not check_command('cwebp'):
        print("cwebp could not be found. Please install webp.")
        sys.exit(1)

    # Check if files were provided as arguments
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <heic_file1> [heic_file2 ...]")
        sys.exit(1)

    # Process each input file
    for file in sys.argv[1:]:
        if file.lower().endswith('.heic'):
            convert_heic_to_webp(file)
        else:
            print(f"Skipping non-HEIC file: {file}")

    print("Conversion complete!")

if __name__ == "__main__":
    main()
