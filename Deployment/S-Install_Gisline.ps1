# Script to install GISLINE
# Version 1.0
# Truls Granli - Sarpsborg kommune


##Variabler##
$path1 = "C:\Program Files\Norkart\GISLINE\Program"
$copy  = '.\lisens\*.*'
$RegistryPath = "HKLM:\SOFTWARE\Sarpsborg kommune\GISLINE" #Pek til ønsket lokasjon i registry
$RegistryName = "GislineVersionIsInstalled" #Skriv inn ønsket navn på "Value".
$RegistryValue = "72" #Skriv inn ønsket "Data Value"
					
##Install pre-reqs x64##
Start-Process msiexec.exe -Wait -ArgumentList '/i sqlncli.msi /qb! /l*v C:\Windows\Temp\SQLCLIx64.log IACCEPTSQLNCLILICENSETERMS=YES' -Verbose
Start-Process .\vcredist_x64_2005.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2008.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2010.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2013.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2015.exe /Q -Verbose -Wait
Start-Process .\vcredist_x64_2017.exe /Q -Verbose -Wait

##Install Gisline with custom modules##
Start-Process msiexec.exe -Wait -ArgumentList '/i GISLINEInstallasjon.msi ADDLOCAL=GISLINE,GISLINEFellesfiler,GISLINETrans,GISLINEPlanregister,GISLINEKOFEdit,GISLINERaster /qb! /norestart ' -Verbose

##Install Gisline Patch##
#Start-Process msiexec.exe -Wait -ArgumentList '/i GISLINE_7.1.1.msp /passive /norestart /l*v C:\Windows\Temp\GislineInstall_Patchx64.log' -Verbose

##Copies files to folder##
Copy-Item $copy -Destination $path1 -Force -Verbose

##Create Detection Method for SCCM##
					
New-Item -Path $RegistryPath -ErrorAction SilentlyContinue -Force -Verbose
New-ItemProperty    -Path $RegistryPath `
                    -Name $RegistryName `
                    -Value $RegistryValue `
                    -PropertyType String `
                    -Force | Out-Null

##CleanUP VCREDIST Files##
Get-ChildItem C:\ -Force -Filter eula* | Where-Object {!$_.PSIsContainer} | Remove-Item -Verbose
Get-ChildItem C:\ -Force -Filter install.res* | Where-Object {!$_.PSIsContainer} | Remove-Item -Verbose
Get-ChildItem C:\ -Force -Filter VC_RED* | Where-Object {!$_.PSIsContainer} | Remove-Item -Verbose
Remove-Item C:\install.exe -Verbose
Remove-Item C:\install.ini -Verbose
Remove-Item C:\msdia80.dll -Verbose
Remove-Item C:\vcredist.bmp -Verbose
Remove-Item C:\globdata.ini -Verbose


