setlocal enableextensions enabledelayedexpansion
@echo off
type %1 | findstr : >> temporaneo.txt
:: type temporaneo.txt
echo %1
for /F "tokens=1-2 delims= " %%x in (temporaneo.txt) do (
	for /F "tokens=1-2 delims=-" %%a in ("%%x") do (
		echo %%a >> start.txt
		echo %%b >> end.txt
	)
)
DEL temporaneo.txt
call %~dp0timesum2.bat end.txt > temporaneo1.txt
for /F "tokens=1-3 delims=:" %%a in (temporaneo1.txt) do (
::	set /a "end=((%%a*60)+1%%b %% 100)*60+1%%c %% 100"
	set /a "end=%%a*3600+%%b*60+%%c"
)
call %~dp0timesum2 start.txt > temporaneo2.txt
for /F "tokens=1-3 delims=:" %%a in (temporaneo2.txt) do (
::	set /a "start=((%%a*60)+1%%b %% 100)*60+1%%c %% 100"
	set /a "start=%%a*3600+%%b*60+%%c"
)
DEL start.txt
DEL end.txt
DEL temporaneo1.txt
DEL temporaneo2.txt
set /A elapsed=end-start
set /A hh=elapsed/3600, rest=elapsed%%3600, mm=rest/60, rest%%=60, ss=rest
if %mm% LSS 10 set mm=0%mm%
if %ss% LSS 10 set ss=0%ss%
echo =
echo %hh%:%mm%:%ss%
echo.