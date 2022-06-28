@echo off
SETLOCAL EnableDelayedExpansion

set cnt=0
set procN=3
set start=0
set end=0
set result=0

set startTs=00:00:00
set endTs=00:00:00

for /F "tokens=1,2 delims=-" %%a in ("%2") do (
    set threS=%%a
    set threE=%%b
)

for /F "tokens=1,2 delims==" %%a in (silencer_logs.txt) do (
    if %%a == lavfi.silence_start (
        set end=%%b
        if !end! NEQ 0 (
            for /f "delims=" %%z in ('cscript //nologo %~dp0eval.vbs "Round(!end!+!threE!,2)"') do (
                set result=%%z
                set result=!result:,=.!
                for /f "delims=" %%z in ('%~dp0secondsToTimestamp !result!') do (
                    set endTs=%%z
                )
                echo !startTs!-!endTs!
                echo !startTs!-!endTs! >> silencer_splitter.txt
            )
        )
    )
    if %%a == lavfi.silence_end (
        set start=%%b
        for /f "delims=" %%z in ('cscript //nologo %~dp0eval.vbs "Round(!start!-!threS!,2)"') do (
            if %%z GEQ 0 (
                set start=%%z
                set start=!start:,=.!

                for /f "delims=" %%z in ('%~dp0secondsToTimestamp !start!') do (
                    set startTs=%%z
                )
            )
        )
    )
)

for /F "tokens=1,2 delims= " %%a in ('ffmpeg -i %1 2^>^&1 ^| findstr Duration') do (
    set endTs=%%b
    set endTs=!endTs:,=!
)
for /f "delims=" %%z in ('%~dp0secondsToTimestamp !start!') do (
    set startTs=%%z
)
echo !startTs!-!endTs!
echo !startTs!-!endTs! >> silencer_splitter.txt