SETLOCAL EnableDelayedExpansion

::silencer "video.mp4" -10dB 2 0.5-0.5
DEL silencer_splitter.txt
DEL silencer_map.txt
ffmpeg -hide_banner -i %1 -vn -acodec copy "%~n1.m4a"
ffmpeg -hide_banner -i "%~n1.m4a" -af silencedetect=noise=%2:d=%3,ametadata=print:file=silencer_logs.txt -f null - -preset ultrafast

@echo off

set duration=0
set start=0
set end=0
set result=0

set startTs=00:00:00
set endTs=00:00:00

for /F "tokens=1,2 delims=-" %%a in ("%4") do (
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
                echo !startTs!-!endTs! >> silencer_splitter.txt

                :: update map duration
                for /f "delims=" %%z in ('cscript //nologo %~dp0eval.vbs "!map!+!result!-!start!"') do (
                    set map=%%z
                    set map=!map:,=.!

                    for /f "delims=" %%z in ('%~dp0secondsToTimestamp !map!') do (
                        echo %%z
                    )
                )
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
    for /f "delims=" %%z in ('%~dp0timestampToSeconds !endTs!') do (
        set end=%%z
    )
)
for /f "delims=" %%z in ('%~dp0secondsToTimestamp !start!') do (
    set startTs=%%z
)
for /f "delims=" %%z in ('cscript //nologo %~dp0eval.vbs "!map!+!end!-!start!"') do (
    set map=%%z
    set map=!map:,=.!
    for /f "delims=" %%z in ('%~dp0secondsToTimestamp !map!') do (
        echo The resulting video will be long between the durations on top and below this message
        echo %%z
    )
)
echo !startTs!-!endTs! >> silencer_splitter.txt

DEL silencer_logs.txt
DEL "%~n1.m4a"