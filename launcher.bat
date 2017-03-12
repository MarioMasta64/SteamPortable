@echo off
Color 0A
title PORTABLE STEAM LAUNCHER
set nag=BE SURE TO TURN CAPS LOCK OFF! (never said it was on just make sure)
set new_version=OFFLINE
cls
if exist replacer.bat del replacer.bat
del version.txt
del version.txt.1

:FOLDERCHECK
cls
if not exist %CD%\bin mkdir %CD%\bin
if not exist %CD%\bin\Steam mkdir %CD%\bin\Steam
if not exist %CD%\doc mkdir %CD%\doc
if not exist %CD%\extra mkdir %CD%\extra
if not exist %CD%\data\appdata mkdir %CD%\data\appdata

:VERSION
echo 4 > %CD%\doc\version.txt
set /p current_version=<%CD%\doc\version.txt

:CREDITS
cls
if exist %CD%\doc\license.txt goto STEAMCHECK
echo ================================================== > %CD%\doc\license.txt
echo =              Script by MarioMasta64            = >> %CD%\doc\license.txt
:: REMOVE SPACE AFTER VERSION HITS DOUBLE DIGITS
echo =            Script Version: v%current_version%-beta            = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
echo =You may Modify this WITH consent of the original= >> %CD%\doc\license.txt
echo = creator, as long as you include a copy of this = >> %CD%\doc\license.txt
echo =      as you include a copy of the License      = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
echo =    You may also modify this script without     = >> %CD%\doc\license.txt
echo =         consent for PERSONAL USE ONLY          = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
start notepad.exe %CD%\doc\license.txt

:STEAMCHECK
cls
if not exist %CD%\bin\Steam\Steam.exe goto FILECHECK
goto WGETUPDATE

:FILECHECK
if not exist %CD%\extra\SteamSetup.exe goto DOWNLOADSTEAM
if not exist %CD%\bin\7-ZipPortable\7-ZipPortable.exe goto 7ZIPINSTALLERCHECK
start %CD%\bin\7-ZipPortable\7-ZipPortable.exe %CD%\extra\SteamSetup.exe
title READMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADME
echo EXTRACT "Steam.exe" TO %CD%\bin\Steam\Steam.exe AND PRESS ENTER TO CONTINUE
pause
goto STEAMCHECK

:DOWNLOADSTEAM
if exist SteamSetup.exe goto MOVESTEAM
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe

:MOVESTEAM
cls
move SteamSetup.exe %CD%\extra\SteamSetup.exe
goto FILECHECK

:7ZIPINSTALLERCHECK
if not exist %CD%\extra\7-ZipPortable_16.04.paf.exe  goto DOWNLOAD7ZIP
start %CD%\extra\7-ZipPortable_16.04.paf.exe
title READMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADME
echo INSTALL 7ZIP PORTABLE TO %CD%\bin\7-ZipPortable AND PRESS ENTER TO CONTINUE
pause
goto FILECHECK

:DOWNLOAD7ZIP
if exist 7-ZipPortable_16.04.paf.exe goto MOVE7ZIP
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe http://downloads.sourceforge.net/portableapps/7-ZipPortable_16.04.paf.exe

:MOVE7ZIP
cls
move 7-ZipPortable_16.04.paf.exe %CD%\extra\7-ZipPortable_16.04.paf.exe
goto FILECHECK

:WGETUPDATE
cls
wget https://eternallybored.org/misc/wget/current/wget.exe
move wget.exe %CD%\bin\
goto MENU

:DOWNLOADWGET
cls
call :CHECKWGETDOWNLOADER
exit /b

:CHECKWGETDOWNLOADER
cls
if not exist %CD%\bin\downloadwget.vbs call :CREATEWGETDOWNLOADER
if exist %CD%\bin\downloadwget.vbs call :EXECUTEWGETDOWNLOADER
exit /b

:CREATEWGETDOWNLOADER
cls
echo ' Set your settings > %CD%\bin\downloadwget.vbs
echo    strFileURL = "https://eternallybored.org/misc/wget/current/wget.exe" >> %CD%\bin\downloadwget.vbs
echo    strHDLocation = "wget.exe" >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo ' Fetch the file >> %CD%\bin\downloadwget.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> %CD%\bin\downloadwget.vbs
echo     objXMLHTTP.send() >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo If objXMLHTTP.Status = 200 Then >> %CD%\bin\downloadwget.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> %CD%\bin\downloadwget.vbs
echo objADOStream.Open >> %CD%\bin\downloadwget.vbs
echo objADOStream.Type = 1 'adTypeBinary >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> %CD%\bin\downloadwget.vbs
echo objADOStream.Position = 0    'Set the stream position to the start >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> %CD%\bin\downloadwget.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> %CD%\bin\downloadwget.vbs
echo Set objFSO = Nothing >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo objADOStream.SaveToFile strHDLocation >> %CD%\bin\downloadwget.vbs
echo objADOStream.Close >> %CD%\bin\downloadwget.vbs
echo Set objADOStream = Nothing >> %CD%\bin\downloadwget.vbs
echo End if >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo Set objXMLHTTP = Nothing >> %CD%\bin\downloadwget.vbs
exit /b

:EXECUTEWGETDOWNLOADER
cls
cscript.exe %CD%\bin\downloadwget.vbs
move wget.exe %CD%\bin\
exit /b

:MENU
cls
title PORTABLE STEAM LAUNCHER - MAIN MENU
echo %NAG%
set nag=SELECTION TIME!
echo 1. reinstall steam [not a feature yet]
echo 2. launch steam
echo 3. reset steam
echo 4. uninstall steam
echo 5. update program
echo 6. about
echo 7. exit
echo.
echo Hey. Thanks for using my project. I was wondering
echo if you would like an option to copy over steam
echo and/or saves from the system to the portable
echo install here. feel free to leave me your answer:
echo loveme0198@gmail.com or on the github:
echo https://github.com/MarioMasta64/SteamPortable
echo Thank You All For Your Kind Response To This! :D
echo.
echo Feel Free To Check Out My Other Projects:
echo https://github.com/MarioMasta64/MinecraftPortable
echo.
set /p choice="enter a number and press enter to confirm: "
if %choice%==1 goto NEW
if %choice%==2 goto DEFAULT
if %choice%==3 goto SELECT
if %choice%==4 goto DELETE
if %choice%==5 goto UPDATECHECK
if %choice%==6 goto ABOUT
if %choice%==7 goto EXIT
set nag="PLEASE SELECT A CHOICE 1-6"
goto MENU

:NULL
set nag="NOT A FEATURE YET!"
goto MENU

:NEW
goto NULL

:DEFAULT
title DO NOT CLOSE - Steam is Running
xcopy /q %CD%\data\appdata\locallow\* %UserProfile%\AppData\LocalLow /e /i /y
set path=%path%;%~d0\dll
set COMMONPROGRAMFILES(X86)=%CD%\bin\commonfiles\
set LOCALAPPDATA=%CD%\data\appdata\local
set APPDATA=%CD%\data\appdata\roaming
cls
echo STEAM IS RUNNING
%CD%\bin\Steam\Steam.exe
:: maybe set a choice of where to go?
goto EXIT

:SELECT
cls
title PORTABLE STEAM LAUNCHER - RESET STEAM
echo %NAG%
set nag=SELECTION TIME!
echo type "yes" to reset steam
echo or anything else to cancel
set /p choice="are you sure: "
if %choice%==yes goto NOWRESETTING
goto MENU

:NOWRESETTING
xcopy /q %CD%\bin\Steam\steam.exe %CD%\extra\ /e /i /y
call :NOWDELETING 1
xcopy /q %CD%\extra\steam.exe %CD%\bin\Steam\ /e /i /y
goto DEFAULT

:DELETE
cls
title PORTABLE STEAM LAUNCHER - UNINSTALL STEAM
echo %NAG%
set nag=SELECTION TIME!
echo type "yes" to uninstall steam
echo or anything else to cancel
set /p choice="are you sure: "
if %choice%==yes call :NOWDELETING 0
goto MENU

:NOWDELETING
set choice=%1
if %choice%==1 title PORTABLE STEAM LAUNCHER - RESETTING STEAM
if %choice%==0 title PORTABLE STEAM LAUNCHER - UNINSTALLING STEAM
cls
echo %NAG%ING
rmdir /s /q %CD%\bin\Steam
cls
if %choice%==1 title PORTABLE STEAM INSTALLER - RESET
if %choice%==0 title PORTABLE STEAM INSTALLER - UNINSTALLED
if %choice%==1 echo STEAM HAS BEEN RESET
if %choice%==0 echo STEAM HAS BEEN UNINSTALLED
pause
exit /b

:UPDATECHECK
cls
if exist version.txt del version.txt
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/SteamPortable/master/version.txt
set /p new_version=<version.txt
if %new_version%==OFFLINE goto ERROROFFLINE
if %current_version% EQU %new_version% goto LATEST
if %current_version% LSS %new_version% goto NEWUPDATE
if %current_version% GTR %new_version% goto NEWEST
goto ERROROFFLINE

:LATEST
cls
title PORTABLE STEAM LAUNCHER - LATEST BUILD :D
echo you are using the latest version!!
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
goto MENU

:NEWUPDATE
cls
echo %NAG%
set nag=SELECTION TIME!
title PORTABLE STEAM LAUNCHER - OLD BUILD D:
echo you are using an older version
echo enter yes or no
echo Current Version: v%current_version%
echo New Version: v%new_version%
set /p choice="Update?: "
if %choice%==yes goto UPDATE
if %choice%==no goto MENU
set nag="please enter YES or NO"
goto NEWUPDATE

:UPDATE
cls
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/SteamPortable/master/launcher.bat
if exist launcher.bat.1 goto REPLACERCREATE
goto ERROROFFLINE

:REPLACERCREATE
cls
echo del launcher.bat >> replacer.bat
echo rename launcher.bat.1 launcher.bat >> replacer.bat
echo start launcher.bat >> replacer.bat
start replacer.bat
exit

:NEWEST
cls
cls
title PORTABLE STEAM LAUNCHER - TEST BUILD :0
echo YOURE USING A TEST BUILD MEANING YOURE EITHER
echo CLOSE TO ME OR YOURE SOME SORT OF PIRATE
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
start launcher.bat
exit

:ABOUT
cls
del %CD%\doc\license.txt
start launcher.bat
exit

:ERROROFFLINE
cls
set nag="YOU SEEM TO BE OFFLINE PLEASE RECONNECT TO THE INTERNET TO USE THIS FEATURE"
goto MENU

:ERROR
cls
echo ERROR OCCURED
pause

:EXIT
xcopy /q %UserProfile%\AppData\LocalLow\* %CD%\data\appdata\locallow /e /i /y
rmdir /s /q %UserProfile%\AppData\LocalLow