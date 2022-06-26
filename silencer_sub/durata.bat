ffmpeg -i %1 2>&1 | findstr Duration >> dacanc.txt
for /f "tokens=*" %%a in (dacanc.txt) do set var=%%a
type dacanc.txt
DEL dacanc.txt


ffmpeg -hide_banner -i %1 -vn -acodec copy a.m4a
ffmpeg -hide_banner -i a.m4a -af silencedetect=noise=%2:d=%3 -f null - -preset ultrafast > ris.txt 2>&1
java -jar C:\ffmpeg\silencer_sub\Silencer2Splitter.jar %1,%4,%cd%,ultrafast,durata,"%var%"
DEL ris.txt
type splitter.txt
DEL splitter.txt
DEL a.m4a