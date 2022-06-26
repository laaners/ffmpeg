@echo off
set testo=%2
set testo=%testo:"=%
set option=%3
set preset=%4%
for /F "tokens=1-2" %%r in (%testo%) do (
	for /F "tokens=1-2 delims=-" %%a in ("%%r") do (
		set start=%%a
		set end=%%b
		@call :body "%~nx1"
	)
)

:body
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
if %option% == -r (
	echo ffmpeg -hide_banner -n -ss %start% -to %end% -i %1 -c copy -map 0 "%title%%~x1"
	ffmpeg -hide_banner -n -ss %start% -to %end% -i %1 -c copy -map 0 "%title%%~x1"
	goto END2
)
if %option% == -p (
	ffmpeg -hide_banner -n -ss %start% -to %end% -i %1 -preset %preset% -acodec aac -vcodec libx264 "%title%%~x1"
	goto END2
)
:END2
echo next
