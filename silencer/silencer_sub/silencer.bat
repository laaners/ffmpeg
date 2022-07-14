::silencer "video.mp4" -10dB 2 0.5-0.5
DEL silencer_splitter.txt
DEL silencer_map.txt
mkdir SILENCER_UNION_FOLDER
ffmpeg -hide_banner -i %1 -vn -acodec copy "%~n1.m4a"
ffmpeg -hide_banner -i "%~n1.m4a" -af silencedetect=noise=%2:d=%3,ametadata=print:file=silencer_logs.txt -f null - -preset ultrafast
call %~dp0getTimestamps.bat %1 %4
move "silencer_splitter.txt" SILENCER_UNION_FOLDER
move %1 SILENCER_UNION_FOLDER
cd SILENCER_UNION_FOLDER
call splitter -p 0 %1 "silencer_splitter.txt" ultrafast
move "silencer_splitter.txt" ..
move %1 ..
cd ..
set ext=%~x1
echo joiner SILENCER_UNION_FOLDER %ext:~1%
call joiner SILENCER_UNION_FOLDER %ext:~1%
DEL silencer_logs.txt
DEL "%~n1.m4a"

@echo off
set /p a="Vuoi la mappa?[y/n]: "
if %a% EQU n (
	goto E
)

call %~dp0getMap.bat

:E
echo Removing:
Rmdir /S SILENCER_UNION_FOLDER