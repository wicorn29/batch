@echo off
setlocal

:: Define the URL of the script to update from
set "SCRIPT_URL=https://raw.githubusercontent.com/username/repository/branch/script.bat"

:: Define the destination path in the startup folder
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "DESTINATION_PATH=%STARTUP_FOLDER%\script.bat"

:: Update the script by downloading the latest version from GitHub
echo Updating script from %SCRIPT_URL%...
powershell -Command "Invoke-WebRequest -Uri %SCRIPT_URL% -OutFile %DESTINATION_PATH%"

:: Check if the update was successful
if exist %DESTINATION_PATH% (
    echo Script updated successfully.

    :: Show a popup saying "hi"
    powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('hi')"
) else (
    echo Failed to update the script.
)

endlocal
exit
