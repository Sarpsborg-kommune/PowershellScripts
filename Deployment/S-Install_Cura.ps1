##Variabler##
$LogPath = 'C:\Windows\Temp\Cura.log'                
$RegistryPath = "HKLM:\SOFTWARE\Sarpsborg kommune\Ultimaker" #Pek til ønsket lokasjon i registry
$RegistryName = "CuraIsInstalled" #Skriv inn ønsket navn på "Value".
$RegistryValue = "1" #Skriv inn ønsket "Data Value"

#Start Logging			
Start-Transcript -Path $LogPath

##Install Software##
Start-Process .\Ultimaker_Cura-4.3.0-win64.exe -Wait -ArgumentList '/S' -Verbose
					
## Create Detection Method for SCCM ##
New-Item -Path $RegistryPath -ErrorAction SilentlyContinue -Verbose
New-ItemProperty    -Path $RegistryPath `
                    -Name $RegistryName `
                    -Value $RegistryValue `
                    -PropertyType String `
                    -Force `
                    -Verbose | Out-Null
Get-ItemProperty $RegistryPath | Select-Object $RegistryName -Verbose


#Stop Logging
Stop-Transcript