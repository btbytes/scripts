#!/usr/bin/env uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "pytesseract",
#     "pdf2image",
# ]
# ///
import sys
import pytesseract
from pdf2image import convert_from_path
import re
import os

def pdf_to_markdown_with_ocr(pdf_filename):
    # Convert PDF to images
    images = convert_from_path(pdf_filename)

    # Perform OCR on each image
    text = ''
    for i, image in enumerate(images):
        # Perform OCR
        page_text = pytesseract.image_to_string(image)

        # Add page number and text
        text += f'## Page {i+1}\n\n{page_text}\n\n'

    # Basic formatting
    # Replace multiple newlines with two newlines
    text = re.sub(r'\n{3,}', '\n\n', text)

    # Add Markdown heading for each line that seems to be a title
    lines = text.split('\n')
    for i, line in enumerate(lines):
        if line.isupper() and len(line.split()) <= 7:
            lines[i] = f'# {line}'

    text = '\n'.join(lines)

    # Generate Markdown filename
    md_filename = os.path.splitext(pdf_filename)[0] + '.md'

    # Write to Markdown file
    with open(md_filename, 'w', encoding='utf-8') as md_file:
        md_file.write(text)

    return md_filename

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <pdf_filename>")
        sys.exit(1)

    pdf_filename = sys.argv[1]
    md_filename = pdf_to_markdown_with_ocr(pdf_filename)
    print(f"Markdown file created: {md_filename}")
