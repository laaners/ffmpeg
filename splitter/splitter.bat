@echo off
if %1 == -h (
	echo splitter -option procs_num "video.mp4" splitter.txt preset
	echo.
	echo option:
	echo -p preciso
	echo -r rapido
	echo.
	echo splitter -p 1 "video.mp4" a.txt veryfast
	goto E
)
set preset=%5
if [%5] == [] (
	@echo on
	set preset=ultrafast
	goto B
)
:B
if %2 == 0 (
	@echo on
	call %~dp0splitter_sub\splitter %3 %4 %1 %preset%
	goto E
)
@echo on
call %~dp0splitter_sub\mproc %3 %4 %2 %1 %preset%
:E
echo DONE!