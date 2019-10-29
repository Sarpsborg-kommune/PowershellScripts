##Variabler##
$LogPath = 'C:\Windows\Temp\'                
$RegistryPath = "HKLM:\SOFTWARE\Sarpsborg kommune\Legevakten" #Pek til ønsket lokasjon i registry
$RegistryName = "ConfigFilesCopied" #Skriv inn ønsket navn på "Value".
$RegistryValue = "1" #Skriv inn ønsket "Data Value"

##Start Logging##
Start-Transcript -Path $LogPath

##Copy Files##
Copy-Item -Path .\MT300_System3_NEW.xml    -Destination "C:\MT-300\XML3\System3.xml" -Recurse -Verbose
Copy-Item -Path .\SDS104_PATHS_NEW.TXT     -Destination "C:\SDS104\PATHS.TXT" -Recurse -Verbose
Copy-Item -Path .\SDS104_SETTINGS_NEW.INI  -Destination "C:\SDS104\SETTINGS.ini" -Recurse -Verbose
Copy-Item -Path .\SEMA200_PATHS_NEW.TXT    -Destination "C:\SEMA200\PATHS.txt" -Recurse -Verbose
Copy-Item -Path .\SEMA200_Settings_NEW.INI -Destination "C:\SEMA200\Settings.ini" -Recurse -Verbose
					
##Create Detection Method for SCCM##
New-Item -Path $RegistryPath -ErrorAction SilentlyContinue -Verbose
New-ItemProperty    -Path $RegistryPath `
                    -Name $RegistryName `
                    -Value $RegistryValue `
                    -PropertyType String `
                    -Force `
                    -Verbose | Out-Null
Get-ItemProperty $RegistryPath | Select-Object $RegistryName -Verbose

##Stop Logging##
Stop-Transcript