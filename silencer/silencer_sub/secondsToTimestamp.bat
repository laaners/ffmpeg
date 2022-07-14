@echo off
SETLOCAL EnableDelayedExpansion

::if already timestamp, stop
for /F "tokens=1,2 delims=:" %%a in ("%1") do (
    if [%%b] NEQ [] (
        echo %1
        goto EXIT
    )
)

::int part and mantissa
for /F "tokens=1,2 delims=." %%a in ("%1") do (
    set s=%%a
    set /a "h=!s!/3600"
    set /a "m=!s!/60 %% 60"
    set /a "s=!s! %% 60"

    if !s! LEQ 9 (
        set s=0!s!
    )

    if !m! LEQ 9 (
        set m=0!m!
    )

    if !h! LEQ 9 (
        set h=0!h!
    )

    set dec=%%b
    if [!dec!] EQU [] (
            echo !h!:!m!:!s!.0
    ) else (
        echo !h!:!m!:!s!.!dec!
    )
)

:EXIT