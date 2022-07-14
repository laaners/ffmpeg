@echo off
SETLOCAL EnableDelayedExpansion
set testo=%2
set testo=%testo:"=%
set option=%4
set preset=%5
set count=0
for /F "tokens=1-2" %%r in (%testo%) do (
	for /F "tokens=1-2 delims=-" %%a in ("%%r") do (
		if !count! EQU %3 (
			@start /wait %~dp0\subroutine "%~nx1" %%a %%b %option% %preset%
			set /a count=0
		)
		@start %~dp0\subroutine "%~nx1" %%a %%b %option% %preset%
		set /a count+=1
	)
)