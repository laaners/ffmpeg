@echo off
set start=%2
set end=%3
set op=%4
set preset=%5
for /F "tokens=1-3 delims=:" %%a in ("%start%") do (
	set tmp1=%%c
	if defined tmp1 (
		set title=%start::=_%
		goto END
	)
	if %%a LSS 10 (
		set title=0_0%start::=_%
		goto END
	)
	set title=0_%start::=_%
)
:END
if %op% == -p (
	ffmpeg -hide_banner -n -ss %start% -to %end% -i %1 -preset %preset% -acodec aac -vcodec libx264 "%title%%~x1"
	goto E
)
if %op% == -r (
	ffmpeg -hide_banner -n -ss %start% -to %end% -i %1 -c copy "%title%%~x1"
	goto E
)
:E
exit