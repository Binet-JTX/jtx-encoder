@echo off
title= ---- Encodeur du JTX ----
color 0C
cls
:start
echo  ******************************************************
echo  ****************** Encodeur du JTX *******************
echo  ******************************************************
echo.
echo Ce programme encode les vid‚os du dossier dans lequel
echo il est plac‚, puis transfŠre les fichiers originaux 
echo dans un dossier Originaux/. 
echo Aucune vid‚o n'est donc supprim‚e.
echo.
echo 1 : FullHD   1920x1080 8 Mbits/s   25 i/s
echo 2 : HD       1280x720  3 Mbits/s   25 i/s
echo 3 : Web      854x480   1.5 Mbits/s 25 i/s
echo 4 : Archives 720x576   1.5 Mbits/s 25 i/s
goto:encodingchoice

:encodingchoice
choice /C 1234 /N /M "S‚lectionez le r‚glage en appuyant sur [1], [2], [3] ou [4] :"
echo.
if errorlevel 4 (
	echo ********************************************************
	echo Encodage au format Archives : 720x576 1.5 Mbits/s 25 i/s
	echo ********************************************************
	call :encoding 4
)
if errorlevel 3 (
	echo ***************************************************
	echo Encodage au format Web : 854x480 1.5 Mbits/s 25 i/s
	echo ***************************************************
	call :encoding 3
)
if errorlevel 2 (
	echo ******************************************
	echo Encodage en HD : 1280x720 3 Mbits/s 25 i/s
	echo ******************************************
	call :encoding 2
)
if errorlevel 1 (
	echo ***********************************************
	echo Encodage en FullHD : 1920x1080 8 Mbits/s 25 i/s
	echo ***********************************************
	call :encoding 1
)
cls
set pute=1
goto:start

:encoding
echo.
md Originaux
color 0a
for %%a in (*.*) do (
	call :encodingcheck %1 "%%a"
)
goto:end

:encodingcheck
set toencode="false"
set extension="%~x2"
if %extension%==".mkv" set toencode="true"
if %extension%==".MKV" set toencode="true"
if %extension%==".avi" set toencode="true"
if %extension%==".AVI" set toencode="true"
if %extension%==".mpg" set toencode="true"
if %extension%==".MPG" set toencode="true"
if %extension%==".webm" set toencode="true"
if %extension%==".WEBM" set toencode="true"
if %extension%==".mp4" set toencode="true"
if %extension%==".MP4" set toencode="true"
if %extension%==".mov" set toencode="true"
if %extension%==".MOV" set toencode="true"
if %extension%==".mts" set toencode="true"
if %extension%==".MTS" set toencode="true"
if %extension%==".mxf" set toencode="true"
if %extension%==".MXF" set toencode="true"
if %toencode%=="true" (
if %1==1 call :fullhd %2
if %1==2 call :hd %2
if %1==3 call :web %2
if %1==4 call :archives %2
)
goto:eof


:fullhd
title= ---- Encodeur du JTX ---- Encodage de "%1" en FullHD
move %1 Originaux/
ffmpeg.exe -i Originaux/%1 -threads 0 -c:v libx264 -b:v 8M -maxrate 12M -r 25 -s 1920x1080 -x264opts level=4 -c:a aac -strict experimental -b:a 192k -y "%~np1.mp4"
goto:eof
:hd
title= ---- Encodeur du JTX ---- Encodage de "%1" en HD
move %1 Originaux/
ffmpeg.exe -i Originaux/%1 -threads 0 -c:v libx264 -b:v 3M -maxrate 4.5M -r 25 -s 1280x720 -x264opts level=3.1 -c:a aac -strict experimental -b:a 192k -y "%~np1.mp4"
goto:eof
:web
title= ---- Encodeur du JTX ---- Encodage de "%1" au format Web
move %1 Originaux/
ffmpeg.exe -i Originaux/%1 -threads 0 -c:v libx264 -b:v 1.5M -maxrate 2.25M -r 25 -s 854x480 -x264opts level=3 -c:a aac -strict experimental -b:a 192k -y "%~np1.mp4"
goto:eof
:archives
title= ---- Encodeur du JTX ---- Encodage de "%1" au format Archives
move %1 Originaux/
ffmpeg.exe -i Originaux/%1 -threads 0 -c:v libx264 -b:v 1.5M -maxrate 2.25M -r 25 -s  720x576 -x264opts level=3 -c:a aac -strict experimental -b:a 192k -y "%~np1.mp4"
goto:eof


:end
color 0b
title= ---- Encodeur Courtine ---- Encodage termine
cls
echo.
echo *****************
echo Fin de l'encodage
echo ******************
echo.
Pause
exit



