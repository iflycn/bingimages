#!/bin/bash

json=$(wget -t 5 --no-check-certificate -qO- "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1")
echo $json | grep -q startdate || exit
url=$(echo https://www.bing.com$(echo $json | sed 's/.\+"url"[:" ]\+//g' | sed 's/".\+//g'))
date=$(echo $json | sed 's/.\+startstartdate[": ]\+//g' | grep -Eo 2[0-9]{7} | head -1)
path=./images/$date"_1920x1080.jpg"
echo "download ["$url"] to ["$path"]"
wget -t 5 --no-check-certificate $url -qO $path
echo "copy ["$path"] to [./today.jpg]"
cp -f $path ./today.jpg
echo "======================"
ls -R
echo "======================"
