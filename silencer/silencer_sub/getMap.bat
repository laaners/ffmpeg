@echo off
SETLOCAL EnableDelayedExpansion

set map=0
for %%f in (SILENCER_UNION_FOLDER/*) do (
    set maptarget=%%~nf
    set video=%%f
    echo !video!
    for /F "tokens=1,2 delims= " %%a in ('ffmpeg -hide_banner -i "SILENCER_UNION_FOLDER/!video!" 2^>^&1 ^| findstr Duration') do (
        set duration=%%b
        set duration=!duration:,=!

        :: update map.txt
        set maptarget=!maptarget:_=:!
        for /f "delims=" %%z in ('%~dp0secondsToTimestamp !map!') do (
            echo %%z-^>!maptarget! >> silencer_map.txt
        )

        :: update map duration
        for /f "delims=" %%z in ('%~dp0timestampToSeconds !duration!') do (
            set duration=%%z
            for /f "delims=" %%z in ('cscript //nologo %~dp0eval.vbs "!map!+!duration!"') do (
                set map=%%z
                set map=!map:,=.!
            )
        )
    )
)