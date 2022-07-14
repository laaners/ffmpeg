@echo off
set path_var=%1
set ext_var=%2
if [%2] == [] (
	set ext_var=mp4
	goto B
)
:B
if %path_var% == -h (
	echo joiner "folder" ext
	echo.
	echo joiner "Nuova_Cartella" mp4
	set path_var="%cd%"
	goto E
)
set path_var=%cd%\%path_var%\
set path_var=%path_var:"=%
for /R "%path_var%" %%f in ("*.%ext_var%") do echo file '%%f' >> join.txt
set title=%path_var::=_%
set title=%title:\=_%
echo correggere join.txt?
pause
if %ext_var% EQU m4a (
	C:\ffmpeg\ffmpeg -f concat -safe 0 -i join.txt -c copy "%title%.mp4"
	C:\ffmpeg\ffmpeg -hide_banner -i "%title%.mp4" -vn -c copy "%title%.m4a"
	del "%title%.mp4"
	goto IF_
)
C:\ffmpeg\ffmpeg -f concat -safe 0 -i join.txt -c copy "%title%.%ext_var%"
:IF_
del join.txt
:E
echo %path_var%
echo DONE!