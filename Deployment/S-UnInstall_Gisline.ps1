# Script to install GISLINE
# Version 1.0
# Truls Granli - Sarpsborg kommune


##Variabler##
$RegistryPath = "HKLM:\SOFTWARE\Sarpsborg kommune\GISLINE" #Pek til ønsket lokasjon i registry
$RegistryName = "GislineVersionIsInstalled" #Skriv inn ønsket navn på "Value".
					
##UnInstall Gisline##
Start-Process msiexec.exe -Wait -ArgumentList '/x {B5EAACDA-3706-4A43-9EE6-A9217EFAE352} /passive /norestart /l*v C:\Windows\Temp\GislineUnInstallx64.log' -Verbose

##Delete Detection Method for SCCM##
Get-Item -Path $RegistryPath | Remove-ItemProperty -Name $RegistryName
