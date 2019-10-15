##Variabler##
$path1 = "C:\Program Files\Norkart\GISLINE\Program"
$copy  = '.\lisens\*.*'

##Install pre-reqs x64##
Start-Process msiexec.exe -Wait -ArgumentList '/i sqlncli.msi /qb! /l*v C:\Windows\Temp\SQLCLIx64.log IACCEPTSQLNCLILICENSETERMS=YES' -Verbose

Start-Process .\vcredist_x64_2005.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2008.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2010.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2013.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2017.exe /Q -Verbose -Wait

##Install Gisline##
Start-Process msiexec.exe -Wait -ArgumentList '/i GISLINEInstallasjon.msi /passive /norestart /l*v C:\Windows\Temp\GislineInstallx64.log' -Verbose

##Install Gisline Patch##
Start-Process msiexec.exe -Wait -ArgumentList '/i GISLINE_7.1.1.msp /passive /norestart /l*v C:\Windows\Temp\GislineInstall_Patchx64.log' -Verbose

##Copies files to folder##
Copy-Item $copy -Destination $path1 -Force -Verbose


