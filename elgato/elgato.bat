@echo off
if %1 == -d (
	ffmpeg -hide_banner -list_devices true -f dshow -i dummy
	goto E
)
if %1 == -r (	
	ffmpeg -hide_banner -ss 0 -to 18000 -f dshow -video_size 1920x1080 -rtbufsize 2147480000 -threads 16 -framerate 60 -i video="Game Capture HD60 S":audio="Game Capture HD60 S Audio" -r 60 -preset superfast -crf 24 soutput.mp4
	goto E
)
if %1 == -ru (
	ffmpeg -hide_banner -ss 0 -to 18000 -f dshow -video_size 1920x1080 -rtbufsize 2147480000 -threads 16 -framerate 60 -i video="Game Capture HD60 S":audio="Game Capture HD60 S Audio" -r 60 -preset ultrafast -crf 24 uoutput.mp4
	goto E
)
if %1 == -ra (	
	ffmpeg -hide_banner -ss 0 -to 18000 -f dshow -rtbufsize 2147480000 -threads 16 -framerate 60 -i audio="Game Capture HD60 S Audio" -vn -preset ultrafast -crf 24 aoutput.m4a
	goto E
)
if %1 == -p (	
	start ffplay -hide_banner -fflags nobuffer -rtbufsize 2147480000 -f dshow -i video="Game Capture HD60 S" -framerate 60 -vf scale=720:-1 -flags low_delay -probesize 32 -preset ultrafast
	ffplay -hide_banner -fflags nobuffer -rtbufsize 2147480000 -f dshow -i audio="Game Capture HD60 S Audio" -flags low_delay -probesize 32 -preset ultrafast
	goto E
)
if %1 == -pn (	
	ffplay -hide_banner -fflags nobuffer -rtbufsize 2147480000 -f dshow -i video="Game Capture HD60 S" -framerate 60 -vf scale=720:-1 -flags low_delay -probesize 32 -preset ultrafast
	goto E
)
if %1 == -ph (
	start ffplay -hide_banner -fflags nobuffer -rtbufsize 2147480000 -f dshow -i video="Game Capture HD60 S" -vf scale=1600:-1 -framerate 60 -flags low_delay -probesize 32 -preset ultrafast
	ffplay -hide_banner -fflags nobuffer -rtbufsize 2147480000 -f dshow -i audio="Game Capture HD60 S Audio" -flags low_delay -probesize 32 -preset ultrafast
	goto E
)
if %1 == -phn (	
	ffplay -hide_banner -fflags nobuffer -rtbufsize 2147480000 -f dshow -i video="Game Capture HD60 S" -vf scale=1600:-1 -framerate 60 -flags low_delay -probesize 32 -preset ultrafast
	goto E
)
if %1 == -check (
	ffplay -hide_banner -fflags nobuffer -rtbufsize 2147480000 -f dshow -i audio="Microphone (Realtek(R) Audio)" -preset ultrafast
	goto E
)
set "TAB=   "
echo elgato -option0
echo.
echo -d
echo %TAB%list devices
echo.
echo -p
echo %TAB%play 720p60FPS with audio
echo.
echo -pn
echo %TAB%play 720p60FPS without audio
echo.
echo -ph
echo %TAB%play 1600p60FPS with audio
echo.
echo -phn
echo %TAB%play 1600p60FPS without audio
echo.
echo -r
echo %TAB%record
echo.
echo -ru
echo %TAB%record ultrafast
echo.
echo -ra
echo %TAB%record audio
echo.
echo -check
echo %TAB%check microphone
echo.
:E