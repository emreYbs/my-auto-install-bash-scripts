#!/bin/bash
# emreybs2023 Updated for more user-friendly version

echo "This script will install youtube-dl"

# Store the youtube-dl path in a variable
YOUTUBE_DL_PATH="/usr/local/bin/youtube-dl"

# Store the youtube-dl download URL in a variable
YOUTUBE_DL_URL="https://yt-dl.org/downloads/latest/youtube-dl"

# Download youtube-dl
if ! sudo wget $YOUTUBE_DL_URL -O $YOUTUBE_DL_PATH; then
    echo "Failed to download youtube-dl. Please check your internet connection and try again."
    exit 1
fi

# Make youtube-dl executable
sudo chmod a+rx $YOUTUBE_DL_PATH

# Update youtube-dl
if ! youtube-dl -U; then
    echo "Failed to update youtube-dl. Please check your internet connection and try again."
    exit 1
fi

echo "youtube-dl installed successfully!"

echo "Usage:"
echo "  Download video: youtube-dl <video_url>"
echo "  Download playlist: youtube-dl -cit <playlist_url>"
echo "  Extract audio: youtube-dl -x <video_url>"




##! /bin/bash
#emreybs2022

#echo "This simple script will install youtube-dl"

#sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl

#sudo chmod a+rx /usr/local/bin/youtube-dl

#youtube-dl -U

###### How to use:   youtube-dl <video_url>
#by adding -f parameter, you can choice the file format and download accordingly.

# Download entire YouTube playlist:  youtube-dl -cit <playlist_url>

#To extract Audio only: youtube-dl -x <video_url>


