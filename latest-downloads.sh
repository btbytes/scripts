#!/usr/bin/env python3

import os
import subprocess
import time
from datetime import datetime
from pathlib import Path


def main():
    current_time = datetime.now()
    current_year = current_time.strftime("%Y")
    current_month = current_time.strftime("%m")

    source_dir = Path.home() / "Downloads"
    dest_dir = Path.home() / f"files.btbytes.com/images/{current_year}/{current_month}"

    # Find the latest PNG (or use the first argument if provided)
    try:
        latest_png = max(source_dir.glob("*.png"), key=os.path.getmtime)
    except ValueError:  # No PNG files found
        print("Error: No PNG files found in the Downloads directory.")
        return

    print(f"File Found: {latest_png}. Cancel if this is not what you want.")
    time.sleep(2)  # Give the user a chance to cancel

    filename = Path(latest_png).stem

    # Create destination directory
    print(f"Going to create {dest_dir}.")
    dest_dir.mkdir(parents=True, exist_ok=True)

    # Convert to WebP
    webp_path = dest_dir / f"{filename}.webp"
    print(f"Converting {latest_png} to {webp_path}")
    subprocess.run(["cwebp", str(latest_png), "-o", str(webp_path)])

    # Print HTML fragment
    image_url = f"https://files.btbytes.com/images/{current_year}/{current_month}/{filename}.webp"
    print(
        f"""<figure>
 <img src="{image_url}" alt="" width=600>
 <figcaption></figcaption>
</figure> [via]()"""
    )

    os.chdir(Path.home() / "files.btbytes.com")
    # Run sync script
    subprocess.run(["./sync.sh"])


if __name__ == "__main__":
    main()
