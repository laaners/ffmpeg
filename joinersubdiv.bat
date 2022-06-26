@echo off
set ext_var=%1
for /D %%p in (*) do (
	set path_var=%%p
	set ext_var=%1
	call :sub
)
goto END

:sub
if [%ext_var%] == [] (
	set ext_var=mp4
	goto B
)
:B
set path_var=%cd%\%path_var%\
set path_var=%path_var:"=%
for /R "%path_var%" %%f in ("*.%ext_var%") do echo file '%%f' >> join.txt
set title=%path_var::=_%
set title=%title:\=_%
if %ext_var% EQU m4a (
	C:\ffmpeg\ffmpeg -f concat -safe 0 -i join.txt -c copy "%title%.mp4"
	C:\ffmpeg\ffmpeg -hide_banner -i "%title%.mp4" -vn -c copy "%title%.m4a"
	del "%title%.mp4"
	goto IF_
)
C:\ffmpeg\ffmpeg -f concat -safe 0 -i join.txt -c copy "%title%.%ext_var%"
:IF_
del join.txt

:END
echo DONE!







