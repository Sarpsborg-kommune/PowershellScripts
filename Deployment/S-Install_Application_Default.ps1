##Variabler##
                
$RegistryPath = "HKLM:\SOFTWARE\Sarpsborg kommune\Office" #Pek til ønsket lokasjon i registry
$RegistryName = "Office365IsInstalled" #Skriv inn ønsket navn på "Value".
$RegistryValue = "1" #Skriv inn ønsket "Data Value"
					
					
##Install Office 365##
Start-Process .\setup.exe -Wait -ArgumentList '/configure O365_With_OneNote2016_x86.xml' -Verbose
					
## Create Detection Method for SCCM ##
					
New-Item -Path $RegistryPath -ErrorAction SilentlyContinue
New-ItemProperty    -Path $RegistryPath `
                    -Name $RegistryName `
                    -Value $RegistryValue `
                    -PropertyType String `
                    -Force | Out-Null