@echo on
title G HUB User Settings Backup
set SCRIPT_PATH=%~dp0
set workdir=%HOMEDRIVE%%HOMEPATH%\AppData\Local\LGHUB\

REM Using the robocopy approach to get a localization-agnostic date-time format. This will be appended to the backup's name to make sure nothing overlaps.
REM Source: https://stackoverflow.com/a/28250863

setlocal
for /f "skip=8 tokens=2,3,4,5,6,7,8 delims=: " %%D in ('robocopy /l * \ \ /ns /nc /ndl /nfl /np /njh /XF * /XD *') do (
    set "month=%%E"
    set "tempday=%%F"
    set "HH=%%H"
    set "MM=%%I"
    set "SS=%%J"
    set "year=%%G"
)

REM Removing the comma from the day string
set day=%tempday:~0,-1%

REM Windows folder names won't let me use a : for times, so there are dots instead
mkdir "%SCRIPT_PATH%G HUB User Settings Backup(%day% %month% %year% %HH%.%MM%.%SS%)"

xcopy %workdir%settings.json "%SCRIPT_PATH%G HUB User Settings Backup(%day% %month% %year% %HH%.%MM%.%SS%)"
xcopy %workdir%settings.backup "%SCRIPT_PATH%G HUB User Settings Backup(%day% %month% %year% %HH%.%MM%.%SS%)"
pause
