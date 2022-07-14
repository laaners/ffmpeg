@echo off
echo %~1
yt-dlp %~1 --external-downloader aria2c --external-downloader-args "-j 16 -s 16 -x 16 -k 5M"