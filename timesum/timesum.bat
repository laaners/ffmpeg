@echo off
if %1 == -n (
	call %~dp0timesum_sub\timesum %2
	goto E
)
if %1 == -t (	
	call %~dp0timesum_sub\times %2
	goto E
)
echo timesum -option time.txt
echo.
echo option:
echo -n per file con solo timestamp singoli
echo 	h1:m1:s1
echo 	h2:m2:s2
echo 	m3:s3
echo.
echo -t per file con start-end
echo 	m1:s1-m2:s2
echo 	m3:s3-h4:m4:s4
echo 	h5:m5:s5-h6:m6:s6
echo.
:E