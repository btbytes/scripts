#!/usr/bin/env uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "pillow",
#     "pillow-heif",
#     "jinja2",
# ]
# ///

import os
import sys
from pathlib import Path
from PIL import Image
from pillow_heif import register_heif_opener
import argparse
from jinja2 import Template

# Register HEIF opener
register_heif_opener()

def convert_heic_to_webp(input_path, output_path):
    with Image.open(input_path) as img:
        img.save(output_path, 'WEBP', quality=85)

def generate_gallery(input_dir, output_dir, output_file, num_files=None):
    input_path = Path(input_dir)
    output_path = Path(output_dir)
    output_path.mkdir(parents=True, exist_ok=True)

    # Get all HEIC files and sort them by creation time (newest first)
    heic_files = sorted(
        input_path.glob('*.HEIC'),
        key=lambda x: x.stat().st_ctime,
        reverse=True
    )

    # Limit the number of files if specified
    if num_files is not None:
        heic_files = heic_files[:num_files]

    images = []

    for heic_file in heic_files:
        webp_file = output_path / f"{heic_file.stem}.webp"
        convert_heic_to_webp(heic_file, webp_file)

        images.append({
            'heic': heic_file.name,
            'webp': webp_file.name,
        })

    # Generate HTML
    template = Template('''
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Image Gallery</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 p-8">
        <div class="container mx-auto">
            <h1 class="text-3xl font-bold mb-8">Image Gallery</h1>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                {% for image in images %}
                    <div class="bg-white p-4 rounded-lg shadow-md">
                        <a href="{{ image.heic }}" download>
                            <img src="{{ image.webp }}" alt="{{ image.heic }}" class="w-full h-auto max-w-[300px] mx-auto">
                        </a>
                    </div>
                {% endfor %}
            </div>
        </div>
    </body>
    </html>
    ''')

    html_content = template.render(images=images)

    with open(output_path / output_file, 'w') as f:
        f.write(html_content)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate an HTML gallery from HEIC images")
    parser.add_argument("input_dir", help="Input directory containing HEIC images")
    parser.add_argument("output_dir", help="Output directory for the gallery")
    parser.add_argument("--output_file", "-o", default="gallery.html", help="Output HTML file name (default: gallery.html)")
    parser.add_argument("-n", type=int, help="Number of most recent files to include in the gallery")

    args = parser.parse_args()

    generate_gallery(args.input_dir, args.output_dir, args.output_file, args.n)
    print(f"Gallery generated: {os.path.join(args.output_dir, args.output_file)}")
