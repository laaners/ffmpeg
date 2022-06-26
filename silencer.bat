@echo off
if %1 == -d (
	@echo on
	call %~dp0silencer_sub\durata %2 %3 %4 %5
	goto E
)
if %1 == -t (
	@echo on
	call %~dp0silencer_sub\silencer %2 %3 %4 %5
	goto E
)
if %1 == -h (
	echo silencer -option "video.mp4" xdB minimum_duration threshold_beginning-threshold_end
	echo.
	echo option:
	echo -d per durata
	echo -t per tutto
	echo x per i primi x secondi del video
	echo.
	echo silencer -d video.mp4 -10dB 2 0-0
	echo silencer -t video.mp4 -10dB 2 0-0
	echo silencer 60 video.mp4 -10dB 2 0-0
	echo silencer 3:28 video.mp4 -10dB 2 0-0
	goto E
)
call %~dp0silencer_sub\silencer-split %2 %3 %4 %5 %1
:E
echo DONE!