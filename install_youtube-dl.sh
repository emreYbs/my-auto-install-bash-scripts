#! /bin/bash
#emreybs2022

echo "This simple script will install youtube-dl"

sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl

sudo chmod a+rx /usr/local/bin/youtube-dl

youtube-dl -U

###### How to use:   youtube-dl <video_url>
#by adding -f parameter, you can choice the file format and download accordingly.

# Download entire YouTube playlist:  youtube-dl -cit <playlist_url>

#To extract Audio only: youtube-dl -x <video_url>
