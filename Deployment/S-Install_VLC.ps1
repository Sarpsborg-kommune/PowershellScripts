##Variabler##
$LogPath = 'C:\Windows\Temp\VLC.log'
$RegistryPath = "HKLM:\SOFTWARE\Sarpsborg kommune\" #Pek til ønsket lokasjon i registry
$RegistryName = "VLCisInstalled" #Skriv inn ønsket navn på "Value".
$RegistryValue = "1" #Skriv inn ønsket "Data Value"

#Start Logging			
Start-Transcript -Path $LogPath

##UnInstall Old version##
if( (Test-Path -Path "$env:ProgramW6432" ) )
{
    Start-Process 'C:\Program Files\VideoLAN\VLC\uninstall.exe' -Wait -ArgumentList '/S' -Verbose
}
    
##Check if "OneDrive is installed"
    if( -Not (Test-Path -Path ${env:ProgramFiles(x86)} ) )
{
    Start-Process 'C:\Program Files (x86)\VideoLAN\VLC\uninstall.exe' -Wait -ArgumentList '/S' -Verbose  
}


##Install Software##
Start-Process .\vlc-3.0.8-win64.exe -Wait -ArgumentList '/language=nb_NO /S' -Verbose

## Create Detection Method for SCCM ##
New-Item -Path $RegistryPath -ErrorAction SilentlyContinue -Verbose -Force
New-ItemProperty    -Path $RegistryPath `
                    -Name $RegistryName `
                    -Value $RegistryValue `
                    -PropertyType String `
                    -Force `
                    -Verbose | Out-Null
Get-ItemProperty $RegistryPath | Select-Object $RegistryName -Verbose


#Stop Logging
Stop-Transcript