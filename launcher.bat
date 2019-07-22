@echo off

color 0A
MODE CON: COLS=32 LINES=8
cls
if exist replacer.bat del replacer.bat
if not exist bin mkdir bin

rmdir /s /q .\doc\
call :MIGRATEFILES
call :UPDATE
exit

:MIGRATEFILES
cls
title=Migrating Steam Files
exit /b

:UPDATE
cls
if not exist .\bin\wget.exe call :DOWNLOADWGET
.\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/EverythingPortable/master/launch_steam.bat
if exist launch_steam.bat echo del launcher.bat > replacer.bat
if exist launch_steam.bat echo start launch_steam.bat >> replacer.bat
if exist launch_steam.bat echo exit >> replacer.bat
start replacer.bat
exit /b

:DOWNLOADWGET
cls
title=Downloading WGET
echo "THE PROJECT HAS BEEN MERGED INTO"
echo "https://github.com/MarioMasta64/EverythingPortable/releases/latest/"
echo "I DONT KNOW WHY YOU STILL DOWNLOADED THIS FILE."
exit /b

:EXECUTEWGETDOWNLOADER
cls
cscript.exe .\bin\downloadwget.vbs
move wget.exe .\bin\
exit /b
