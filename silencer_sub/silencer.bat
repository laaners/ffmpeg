DEL dacanc.txt
ffmpeg -i %1 2>&1 | findstr Duration >> dacanc.txt
for /f "tokens=*" %%a in (dacanc.txt) do set var=%%a
echo %4 > dacanc.txt
echo %var% >> dacanc.txt
mkdir UNION_FOLDER
ffmpeg -hide_banner -i %1 -vn -acodec copy a.m4a
ffmpeg -hide_banner -i a.m4a -af silencedetect=noise=%2:d=%3 -f null - -preset ultrafast > ris.txt 2>&1
node C:\ffmpeg\silencer_sub\Silencer2Splitter.js > splitter.txt
move "%1" UNION_FOLDER
move "splitter.txt" UNION_FOLDER
cd UNION_FOLDER
call splitter -p 5 "%1" "splitter.txt" ultrafast
pause
move "%1" ..
move "splitter.txt" ..
cd ..
set ext=%~x1
echo joiner UNION_FOLDER %ext:~1%
call joiner UNION_FOLDER %ext:~1%
DEL ris.txt
DEL splitter.txt
DEL a.m4a
DEL dacanc.txt

@echo off
set /p a="Vuoi la mappa?[y/n]: "
if %a% EQU n (
	goto E
)
@echo on
cd UNION_FOLDER
for %%f in (*%~x1) do ffmpeg -i "%%f" 2>&1 | findstr "Duration from" >> "..\mappa.txt"
cd ..
java -jar C:\ffmpeg\silencer_sub\Map.jar
DEL mappa.txt
:E
Rmdir /S UNION_FOLDER

::ffmpeg -i %1 2>&1 | findstr Duration >> dacanc.txt
::for /f "tokens=*" %%a in (dacanc.txt) do set var=%%a
::type dacanc.txt
::DEL dacanc.txt
::
::mkdir UNION_FOLDER
::ffmpeg -hide_banner -i %1 -vn -acodec copy a.m4a
::ffmpeg -hide_banner -i a.m4a -af silencedetect=noise=%2:d=%3 -f null - -preset ultrafast > ris.txt 2>&1
::java -jar C:\ffmpeg\silencer_sub\Silencer2Splitter.jar %1,%4,%cd%,ultrafast,rrapido,"%var%"
::DEL ris.txt
::DEL splitter.txt
::DEL a.m4a
::cd UNION_FOLDER
::for %%f in (*%~x1) do echo file '%%~ff' >> join.txt
::ffmpeg -hide_banner -f concat -safe 0 -i join.txt -c copy united.mp4
::move united.mp4 ..
::
::@echo off
::set /p a="Vuoi la mappa?[y/n]: "
::if %a% EQU n (
::	goto E
::)
::@echo on
::for %%f in (*%~x1) do ffmpeg -i "%%f" 2>&1 | findstr "Duration from" >> "..\mappa.txt"
:::E
::cd ..
::java -jar C:\ffmpeg\silencer_sub\Map.jar
::DEL mappa.txt
::Rmdir /S UNION_FOLDER