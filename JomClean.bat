@ECHO OFF
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

@ECHO OFF
C:
CD\
CLS

:MENU
CLS

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO 1.  System File Check
ECHO 2.  DISM Restore Health
ECHO 3.  DISM Component Cleanup
ECHO 4.  Windows Update Fix
ECHO 5.  Group Policy Sync
ECHO 6.  Clear Credential Manager
ECHO 7.  Unmap All Network Drives
::ECHO 8.  UNUSED
::ECHO 9.  UNUSED
ECHO -------------------------------------
ECHO 0.  Info
ECHO -------------------------------------
ECHO ==========PRESS 'Q' TO QUIT==========
ECHO.

SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO Selection1
IF /I '%INPUT%'=='2' GOTO Selection2
IF /I '%INPUT%'=='3' GOTO Selection3
IF /I '%INPUT%'=='4' GOTO Selection4
IF /I '%INPUT%'=='5' GOTO Selection5
IF /I '%INPUT%'=='6' GOTO Selection6
IF /I '%INPUT%'=='7' GOTO Selection7
::IF /I '%INPUT%'=='8' GOTO Selection8
::IF /I '%INPUT%'=='9' GOTO Selection9
IF /I '%INPUT%'=='0' GOTO Selection0
IF /I '%INPUT%'=='Q' GOTO Quit

CLS

ECHO ============ I AM ERROR =============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [0-9] or select 'Q' to quit.
ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

PAUSE > NUL
GOTO MENU

:Selection1

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO ----- Running System File Check -----

sfc /scannow

ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

PAUSE > NUL
GOTO MENU

:Selection2

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO ---- Running DISM Restore Health ----

dism /online /cleanup-image /restorehealth

ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

PAUSE > NUL
GOTO MENU

:Selection3

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO -- Running DISM Component Cleanup ---

dism /online /cleanup-image /startcomponentcleanup /resetbase

ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

PAUSE > NUL
GOTO MENU

:Selection4

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO ---- Running Windows Update Fix -----

ECHO --------- Stopping Services ---------

@ECHO OFF
net stop wuauserv
net stop CryptSvc
net stop BITS
net stop msiserver

ECHO ---------- Clearing Cache -----------

@ECHO OFF
rmdir /s /q C:\windows\SoftwareDistribution
rmdir /s /q C:\windows\system32\catroot2

ECHO --------- Starting Services ---------

@ECHO OFF
net start wuauserv
net start cryptsvc
net start bits
net start msiserver

ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

PAUSE > NUL
GOTO MENU

:Selection5

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO ----- Running Group Policy Sync -----

gpupdate /force

ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

:Selection6

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO ---- Clearing Credential Manager ---- 

@ECHO OFF
for /F "tokens=1,2 delims= " %G in ('cmdkey /list ^| findstr Target') do cmdkey /delete %H

ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

:Selection7

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO ------ Unmapping Network Drives -----

net use *  /delete /y

ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

:Selection8

and so on

:Selection9



:Selection0

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO            About JOMCLEAN
ECHO -------------------------------------
ECHO   JOMCLEAN is an all-in-one Windows    
ECHO utility to clean up and repair the
ECHO most common Windows issues.
ECHO -------------------------------------
ECHO   More options coming soon!
ECHO -------------------------------------
ECHO   For new users, run the options in
ECHO order, starting from option 1.
ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====

PAUSE > NUL
GOTO MENU

:Quit
CLS

ECHO =========== JOMCLEAN v1.1 ===========
ECHO -------------------------------------
ECHO ---- Thanks for using JOMCLEAN! -----
ECHO -------------------------------------
ECHO ======= PRESS ANY KEY TO EXIT =======

PAUSE>NUL
EXIT