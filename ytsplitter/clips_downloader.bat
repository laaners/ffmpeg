@echo off
setlocal enabledelayedexpansion

yt-dlp -U
DEL tmp_dsa.txt

set /p yt_bool="Video youtube? [s/n]: "

echo.
set /p video_url="Incolla l'url del video: "

yt-dlp -F "!video_url!"
echo.
set /p format="Formato del video: "

yt-dlp -f %format% -g "!video_url!" >> tmp_dsa.txt

for /F "tokens=*" %%a in (tmp_dsa.txt) do set video=%%a

if [!yt_bool!] == [s] (
	yt-dlp -f 140 -g "!video_url!" >> tmp_dsa.txt
	for /F "tokens=*" %%a in (tmp_dsa.txt) do set audio=%%a
)

for /F "tokens=1-2 delims=-" %%a in (splitter.txt) do (
	set start=%%a
	set title=!start::=_!
	if exist "!title!.mp4" (
		echo !title!.mp4 esiste già
	) else (
		if [!yt_bool!] == [s] (
			ffmpeg -n -hide_banner -fflags +discardcorrupt -ss %%a -to %%b -i "%video%" -ss %%a -to %%b -i "%audio%" -map 0:v -map 1:a -c:v libx264 -c:a aac -preset veryfast "!title!.mp4"
			DEL "!title!.m4a"
		) else (
			ffmpeg -fflags +discardcorrupt -n -hide_banner -ss %%a -to %%b -i "%video%" -c:v libx264 -c:a aac -preset veryfast "!title!.mp4"
		)
	)
	echo.
)
DEL tmp_dsa.txt

echo Ho finito! Invio per chiudermi
pause