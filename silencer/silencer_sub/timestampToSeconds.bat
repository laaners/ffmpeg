@echo off
SETLOCAL EnableDelayedExpansion

::if already seconds, stop
for /F "tokens=1,2 delims=:" %%a in ("%1") do (
    if [%%b] EQU [] (
        echo %1
        goto EXIT
    )
)


for /F "tokens=1,2 delims=." %%a in ("%1") do (
    set ts=%%a
    set dec=%%b
    for /F "tokens=1-3 delims=:" %%a in ("!ts!") do (
        set /a "s=(100%%a %% 100)*3600+(100%%b %% 100)*60+(100%%c %% 100)*1"
        if [!dec!] EQU [] (
            echo !s!.0
        ) else (
            echo !s!.!dec!
        )
    )
)

:EXIT