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
echo silencer -option "video.mp4" xdB minimum_duration threshold_beginning-threshold_end
echo.
echo option:
echo -d get duration only of output video
echo -t start the operation
echo.
echo silencer -d video.mp4 -10dB 2 0-0
echo silencer -t video.mp4 -30dB 3 0.5-0.7
goto E
:E
echo DONE!