# Script to Copy GatFlexto to KIOSK computers
# Version 1.0
# Truls Granli - Sarpsborg kommune

# Create Registry Keys and copy CMTrace.exe file to C:\Windows
Copy-Item "$($PSScriptRoot)\GatFlexTimeClock" -Destination "$($env:USERPROFILE)\GatFlexTimeClock" -Force