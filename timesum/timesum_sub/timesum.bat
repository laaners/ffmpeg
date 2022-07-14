setlocal enableextensions enabledelayedexpansion
@echo off
type %1 | findstr : >> temporaneo.txt
:: type temporaneo.txt
echo %1
set h=0
set m=0
set s=0
for /F "tokens=1-3 delims=:" %%a in (temporaneo.txt) do call :body %%a %%b %%c
set /a "m+=(%s%-%s% %% 60)/60"
set /a "s=(%s% %% 60)"
set /a "h+=(%m%-%m% %% 60)/60"
set /a "m=(%m% %% 60)"
echo =
if %m% lss 10 set m=0%m%
if %s% lss 10 set s=0%s%
echo %h%:%m%:%s%
echo.
DEL temporaneo.txt
goto E

:body
set a=%1
set b=%2
set tmp=%3
if defined tmp (
	set /a "h+=(100%a% %% 100)"
	set /a "m+=(100%b% %% 100)" 
	set /a "s+=(100%tmp% %% 100)"
	goto E
)
set /a "m+=(100%a% %% 100)" 
set /a "s+=(100%b% %% 100)"
:E