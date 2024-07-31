@echo off
setlocal

REM Get the path to the Startup folder
set "startup_folder=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Check if any files were dragged onto the script
if "%~1"=="" (
    echo No files were dragged onto the script.
    pause
    exit /b 1
)

REM Loop through all the files dragged onto the script
:loop
if "%~1"=="" goto endloop

REM Move the file to the Startup folder
move "%~1" "%startup_folder%"

REM Shift to the next file
shift
goto loop

:endloop
echo All files have been moved to the Startup folder.
pause
endlocal
