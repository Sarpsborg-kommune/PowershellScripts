# Script to uninstall Ultimaker Cura
# Version 1.0
# Truls Granli - Sarpsborg kommune


##Variabler##
$RegistryPath = "HKLM:\SOFTWARE\Sarpsborg kommune\Ultimaker" #Pek til ønsket lokasjon i registry
$RegistryName = "GCuraIsInstalled" #Skriv inn ønsket navn på "Value".
					
##UnInstall Gisline##
Start-Process 'C:\Program Files\Ultimaker Cura 4.3\Uninstall.exe' -Wait -ArgumentList '/S' -Verbose

##Delete Detection Method for SCCM##
Get-Item -Path $RegistryPath | Remove-ItemProperty -Name $RegistryName
