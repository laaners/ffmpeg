@echo off
for %%a in (%1) do (
 if not exist "%%~na" mkdir "%%~na"
	if exist "%%~na" (
		ffmpeg -i "%%a" -an -qscale:v 1 "%%~na"/"%%~na_%%10d.png"
	)
)