::============================================================
::=============== Programme d'encodage du JTX ================
::============================================================
::====== Par Denis Merigoux, inspir� de Nicolas Breton =======
::============================================================

::ffmpeg v2.7.2 doit �tre plac� dans le m�me dossier que le .bat pour que celui-ci fonctionne.
::Alternativement, on packagera le .bat et ffmpeg.exe � l'int�rieur d'un unique .exe
::� l'aide de http://www.f2ko.de/en/b2e.php pour plus de portabilit� et de protection du code.




::On se r�f�rera au site http://ss64.com/ pour la documentation des commandes batch
@echo off
::Titre de la fen�tre de ligne de commande.
title= ---- Encodeur du JTX ----
::Couleur du texte et du fond
color 0D
::Efface l'�cran
cls
echo    ******************************************************
echo    ****************** Encodeur du JTX *******************
echo    ******************************************************
echo.
echo    Ce programme dispose de deux modes de fonctionnement.
echo.
echo    - Dans le mode 1, ce programme encode toutes les vid�os du dossier
echo    dans lequel il est plac�, puis transf�re les fichiers originaux 
echo    dans un dossier Originaux/. Aucune vid�o n'est donc supprim�e.
echo.
echo    - Dans le mode 2, le programme encode tous les rushes (.MTS, .MXF,
echo    .MOV, .MP4, .MVI) pr�sents dans le dossier et les sous-dossiers de
echo    l'endroit o� est situ� le programme. Les originaux sont supprim�s.
echo.
echo    *******************************************************
echo     Attention, le mode 2 supprime les vid�os originales ! 
echo    *******************************************************
echo.    
choice /C 12 /N /M "    S�lectionne le mode de fonctionnement, [1] ou [2] :"
if errorlevel 2 (
	call :recursivemode
)
if errorlevel 1 (
    call :normalmode
)

color 0b
title= ---- Encodeur du JTX ---- Encodage termine
cls
echo.
echo    ***************************
echo    **** Fin de l'encodage ****
echo    ***************************
echo.
echo    L'encodage du dossier suivant est termin� :
echo    %cd%
echo.
echo    Merci d'avoir choisi l'encodeur du JTX !
echo.
echo    Appuie sur une touche pour quitter le programme.
pause >nul
exit

:normalmode 
cls
echo.
echo    Tu as choisi le mode normal, qui encode toutes les vid�os pr�sentes dans ce dossier.
echo.
echo	Assure-toi d'ex�cuter ce programme dans un dossier o� tu as les
echo	droits dex�cution sur tous les fichiers.
echo.
echo    Voici la liste des formats d'encodage disponibles :
echo    1 : FullHD   1920x1080 10 Mbits/s  25 i/s
echo    2 : HD       1280x720  3 Mbits/s   25 i/s
echo    3 : Web      854x480   1.5 Mbits/s 25 i/s
echo    4 : Archives 720x576   1.5 Mbits/s 25 i/s
echo.
::Affiche un prompt d'une seule touche
choice /C 1234 /N /M "   S�lectionez le r�glage en appuyant sur [1], [2], [3] ou [4] :"
::R�cup�ration mystique du r�sultat de choice
::L'ordre des if est important (?!)...
if errorlevel 4 (
	echo.
	color 0E
	echo    ********************************************************
	echo    Encodage au format Archives : 720x576 1.5 Mbits/s 25 i/s
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	::Appel de la routine :encoding avec le param�tre 4
	call :normalencoding 4
)
if errorlevel 3 (
	echo.
	color 0E
	echo    ********************************************************
	echo    * Encodage au format Web : 854x480 1.5 Mbits/s 25 i/s **
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	call :normalencoding 3
)
if errorlevel 2 (
	echo.
	color 0E
	echo    ********************************************************
	echo    ****** Encodage en HD : 1280x720 3 Mbits/s 25 i/s ******
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	call :normalencoding 2
)
if errorlevel 1 (
	echo.
	color 0E
	echo    ********************************************************
	echo    *** Encodage en FullHD : 1920x1080 10 Mbits/s 25 i/s ***
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	call :normalencoding 1
)
goto:eof

:normalencoding
echo.
::Cr�er le r�pertoire des fichiers originaux
md Originaux
color 0a
::Boucle sur tous les fichiers du dossier en cours
::%%a est le nom du fichier
for %%a in (*.*) do (
	call :normalencodingcheck %1 "%%a"
)
::Lors de l'ex�cution, le goto am�ne le programme au label :end.
goto:eof

::V�rifie si le fichier peut �tre encod�
:normalencodingcheck
set toencode="false"
set extension="%~x2"
::Ci dessous une liste d'extensions correspondant � tous les formats vid�os usuels
if %extension%==".mkv" set toencode="true"
if %extension%==".MKV" set toencode="true"

if %extension%==".wmv" set toencode="true"
if %extension%==".WMV" set toencode="true"

if %extension%==".ogm" set toencode="true"
if %extension%==".OGM" set toencode="true"

if %extension%==".3gp" set toencode="true"
if %extension%==".3GP" set toencode="true"

if %extension%==".ts" set toencode="true"
if %extension%==".TS" set toencode="true"

if %extension%==".m2ts" set toencode="true"
if %extension%==".M2TS" set toencode="true"

if %extension%==".flv" set toencode="true"
if %extension%==".FLV" set toencode="true"

if %extension%==".m4v" set toencode="true"
if %extension%==".M4V" set toencode="true"


if %extension%==".rm" set toencode="true"
if %extension%==".RM" set toencode="true"

if %extension%==".mvi" set toencode="true"
if %extension%==".MVI" set toencode="true"

if %extension%==".mka" set toencode="true"
if %extension%==".MKA" set toencode="true"

if %extension%==".dvix" set toencode="true"
if %extension%==".DVIX" set toencode="true"

if %extension%==".mks" set toencode="true"
if %extension%==".MKS" set toencode="true"

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
    move %2 Originaux/
	if %1==1 call :fullhd "Originaux/%~2" "%~np2.mp4"
	if %1==2 call :hd "Originaux/%~2" "%~np2.mp4"
	if %1==3 call :web "Originaux/%~2" "%~np2.mp4"
	if %1==4 call :archives "Originaux/%~2" "%~np2.mp4"
)
::Le label :eof est pr�defini et permet de retourner � l'endroit du code o� la routine a �t� appel�e.
goto:eof


:recursivemode
cls
echo.
echo    Tu as choisi le mode r�cursif, qui encode tous les rushes
echo    (.MTS, .MXF, .MOV, .MP4, .MVI) r�cursivement sur tous les
echo    sous-dossiers � partir de l'emplacement du programme.
echo.
echo    *******************************************************
echo     Attention, le mode 2 supprime les vid�os originales ! 
echo    *******************************************************
echo.    
echo. 
choice /C yn /N /M "   Veux-tu vraiment lancer ce mode ? [y/n]"
if errorlevel 2 (
   exit
)
echo.
echo	Assure-toi d'ex�cuter ce programme dans un dossier o� tu as les
echo	droits dex�cution sur tous les fichiers.
echo.
echo    Voici la liste des formats d'encodage disponibles :
echo    1 : FullHD   1920x1080 10 Mbits/s  25 i/s
echo    2 : HD       1280x720  3 Mbits/s   25 i/s
echo    3 : Web      854x480   1.5 Mbits/s 25 i/s
echo    4 : Archives 720x576   1.5 Mbits/s 25 i/s
echo.
::Affiche un prompt d'une seule touche
choice /C 1234 /N /M "   S�lectionez le r�glage en appuyant sur [1], [2], [3] ou [4] :"
::R�cup�ration mystique du r�sultat de choice
::L'ordre des if est important (?!)...
if errorlevel 4 (
	echo.
	color 0E
	echo    ********************************************************
	echo    Encodage au format Archives : 720x576 1.5 Mbits/s 25 i/s
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	::Appel de la routine :encoding avec le param�tre 4
	call :recursiveencoding 4
)
if errorlevel 3 (
	echo.
	color 0E
	echo    ********************************************************
	echo    * Encodage au format Web : 854x480 1.5 Mbits/s 25 i/s **
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	call :recursiveencoding 3
)
if errorlevel 2 (
	echo.
	color 0E
	echo    ********************************************************
	echo    ****** Encodage en HD : 1280x720 3 Mbits/s 25 i/s ******
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	call :recursiveencoding 2
)
if errorlevel 1 (
	echo.
	color 0E
	echo    ********************************************************
	echo    *** Encodage en FullHD : 1920x1080 10 Mbits/s 25 i/s ***
	echo    ********************************************************
	echo    ***** Appuie sur un touche pour lancer l'encodage ******
	echo    ********************************************************
	pause >nul
	call :recursiveencoding 1
)
goto:eof

:recursiveencoding
echo.
color 0a
::Boucle sur tous les fichiers du dossier en cours
::%%a est le nom du fichier
for /R %%a in (*.*) do (
	call :recursiveencodingcheck %1 "%%a"
)
::Lors de l'ex�cution, le goto am�ne le programme au label :end.
goto:eof

::V�rifie si le fichier peut �tre encod�
:recursiveencodingcheck
set toencode="false"
set extension="%~x2"
::Ci dessous une liste d'extensions correspondant � tous les formats de rushes usuels
if %extension%==".mvi" set toencode="true"
if %extension%==".MVI" set toencode="true"

if %extension%==".MP4" set toencode="true"

if %extension%==".MPG" set toencode="true"

if %extension%==".mov" set toencode="true"
if %extension%==".MOV" set toencode="true"

if %extension%==".mts" set toencode="true"
if %extension%==".MTS" set toencode="true"

if %extension%==".mxf" set toencode="true"
if %extension%==".MXF" set toencode="true"

::Comme on rajoute _encode au nom du fichier apr�s encodage, ce filtre permet de ne pas r�encoder des fichiers d�j� encod�s.
set basename=%~np2
if "%basename:~-7%"=="_encode" set toencode="false"

if %toencode%=="true" (
	if %1==1 call :fullhd "%~2" "%~np2_encode.mp4"
	if %1==2 call :hd "%~2" "%~np2_encode.mp4"
	if %1==3 call :web "%~2" "%~np2_encode.mp4"
	if %1==4 call :archives "%~2" "%~np2_encode.mp4"
	IF NOT ERRORLEVEL 1 del "%~2"
)
::Le label :eof est pr�defini et permet de retourner � l'endroit du code o� la routine a �t� appel�e.
goto:eof







::Ci dessous les commandes d'encodage qui font appel � ffmpeg v2.7.2 (https://www.ffmpeg.org/)
::Liste des param�tres utilis�s par les commandes :
::	-i <input>
::		Fichier original � encoder.
::	-threads <number>
::		Nombre de CPU utilis�s pour r�aliser l'encodage. Si 0, un maximum de CPU sont utilis�s.
::	-c:v <codec>
::		Codec vid�o, le JTX a choisi d'utiliser H.264 impl�ment� par la librairie libx264.
::	-b:v <number>
::		Bitrate de la vid�o en sortie, exprim� en bits.
::	-r <number>
::		Framerate de la vid�o en sortie.
::	-s <width>x<hright>
::		R�solution de la vid�o en sortie, exprim�e en pixels.
::	-x264opts <options>
::		Permet de sp�cifier des options pour la libraire libx264. En l'occurence, on d�termine
::		ici le level de l'encodage H.264. Plus d'infos ici : https://fr.wikipedia.org/wiki/H.264#Niveaux.
::	-pix_fmt <format>
::		Format d'encodage des pixels. yuv420p est sp�cifi� ici car sinon les vid�os ne sont pas
::		lisibles par Windows Media Player. Plus d'infos ici : https://ffmpeg.zeranoe.com/forum/viewtopic.php?t=709.
::	-c:a <codec>
::		Codec audio de la vid�o en sortie. Le JTX a choisi AAC.
::	-strict <strictness>
::		Le codec audio AAC �tant une fonctionnalit� exp�rimentale pour ffmpeg 2.7.2, il est n�cessaire
::		de r�gler ce param�tre sur experimental.
::	-b:a <number>
::		Bitrate de l'audio en sortie. Le JTX a choisi 192k.
::	-y
::		�crase automatiquement les fichiers en sortie s'ils existent d�j� (pas de prompt).

:fullhd
title= ---- Encodeur du JTX ---- Encodage de %1 en FullHD
ffmpeg.exe -i %1 -threads 0 -c:v libx264 -b:v 10M -r 25 -s 1920x1080 -x264opts level=4 -pix_fmt yuv420p -c:a aac -strict experimental -b:a 192k -y %2
goto:eof
:hd
title= ---- Encodeur du JTX ---- Encodage de %1 en HD
ffmpeg.exe -i %1 -threads 0 -c:v libx264 -b:v 3M -r 25 -s 1280x720 -x264opts level=3.1 -pix_fmt yuv420p -c:a aac -strict experimental -b:a 192k -y %2
goto:eof
:web
title= ---- Encodeur du JTX ---- Encodage de %1 au format Web
move %1 Originaux/
ffmpeg.exe -i %1 -threads 0 -c:v libx264 -b:v 1.5M -r 25 -s 854x480 -x264opts level=3 -pix_fmt yuv420p -c:a aac -strict experimental -b:a 192k -y %2
goto:eof
:archives
title= ---- Encodeur du JTX ---- Encodage de %1 au format Archives
ffmpeg.exe -i %1 -threads 0 -c:v libx264 -b:v 1.5M -r 25 -s  720x576 -x264opts level=3 -pix_fmt yuv420p -c:a aac -strict experimental -b:a 192k -y %2
goto:eof



