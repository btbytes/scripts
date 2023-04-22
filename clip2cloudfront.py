#!/usr/bin/env python3

"""
clip2cloudfront.py - uploads an image in the clipboard to cloudront bucket
and prints the uploaded image's URL.

Requires: Python3 and PIL library

Pradeep Gowda
2023-03-12
"""

from base64 import b64encode
from io import BytesIO
from os import getenv
from PIL import ImageGrab
from requests import post
from sys import exit


def upload(client_id, client_secret):
    headers = {"Authorization": "Client-ID " + client_id}
    url = "https://api.imgur.com/3/upload"
    buffered = BytesIO()
    img = ImageGrab.grabclipboard()
    if not img:
        print(f"Clipboard does not appear to contain an image")
        exit(0)
    img.save(buffered, format="PNG")
    response = post(
        url,
        headers=headers,
        data={
            "key": client_secret,
            "image": b64encode(buffered.getvalue()),
            "type": "base64",
        },
    )
    link = response.json()["data"]["link"]
    return link


def main():
    client_id = getenv("IMGUR_CLIENT_ID")
    client_secret = getenv("IMGUR_CLIENT_SECRET")
    if not (client_id and client_secret):
        print(f"client_id={client_id}, client_secret={client_secret}")
        print("Set IMGUR_CLIENT_ID and IMGUR_CLIENT_SECRET")
        exit(0)
    link = upload(client_id, client_secret)
    print(link)


if __name__ == "__main__":
    main()
