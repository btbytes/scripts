#!/bin/bash
# A script to take a screenshot on linux and upload
# it to your public dropbox directory and have the public
# URL be copied to your clipboard
# Credit: HN User Inufu - http://news.ycombinator.com/item?id=4841729

# to install dependencies
# sudo apt-get install scrot xclip

userid="111920" #change this to your Dropbox ID, ofcourse.
myfile=$(date +%Y%m%d%S).png
scrot -s "$HOME/Dropbox/Public/$myfile" 
echo "http://dl.dropbox.com/u/$userid/$myfile" | xclip -selection c
notify-send "Done"
