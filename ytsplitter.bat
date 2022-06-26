@echo off
setlocal enabledelayedexpansion
DEL tmp_dsa.txt
yt-dlp -F %1
echo.
set /p format="Quale formato? "
yt-dlp -f %format% -g %1 >> tmp_dsa.txt
echo.
for /F "tokens=*" %%a in (tmp_dsa.txt) do set video=%%a

if [%3] == [] (
	goto B
)
yt-dlp -f %3 -g %1 >> tmp_dsa.txt
echo.
for /F "tokens=*" %%a in (tmp_dsa.txt) do set audio=%%a

:B
::for /F "tokens=1-2 delims=-" %%a in (%2) do (
type %2 > tmp_dsa.txt
for /F "tokens=1-2 delims=-" %%a in (tmp_dsa.txt) do (
	set start=%%a
	set title=!start::=_!
	if exist "!title!.mp4" (
		echo !title!.mp4 esiste già
	) else (
		if [%3] == [] (
			echo ffmpeg -ss %%a -to %%b -i "%video%" -c copy "!title!.mp4"
			::ffmpeg -n -hide_banner -ss %%a -to %%b -i "%video%" -c copy "!title!.mp4"
			ffmpeg -n -hide_banner -ss %%a -to %%b -i "%video%" -c:v libx264 -c:a aac -preset veryfast "!title!.mp4"
		) else (
			echo ffmpeg -ss %%a -to %%b -i "%video%" -ss %%a -to %%b -i "%audio%" -map 0:v -map 1:a -c copy "!title!.mp4"
			ffmpeg -ss %%a -to %%b -i "%video%" -ss %%a -to %%b -i "%audio%" -map 0:v -map 1:a -c copy "!title!.mp4"
		)
	)
	echo.
)
DEL tmp_dsa.txt
