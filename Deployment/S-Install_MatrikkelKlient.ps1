##Variabler##
$LogPath = 'C:\Windows\Temp\'                
$RegistryPath = "HKCU:\SOFTWARE\Sarpsborg kommune\Matrikkel" #Pek til ønsket lokasjon i registry
$RegistryName = "IsInstalled" #Skriv inn ønsket navn på "Value".
$RegistryValue = "11" #Skriv inn ønsket "Data Value"


##Start Logging##
Start-Transcript -Path $LogPath

##Copy Files##
Copy-Item -Path .\Klient  -Destination $Env:USERPROFILE\AppData\Local\Kartverket\Matrikkel\Matrikkelklient-1.1 -Recurse -Verbose -Force

##Create Shortcut##
if( (Test-Path -Path "$env:USERPROFILE\OneDrive - Sarpsborg kommune" ) )
{
    $TargetFile =  "$Env:USERPROFILE\AppData\Local\Kartverket\Matrikkel\Matrikkelklient-1.1\matrikkelklient.exe"
    $ShortcutFile = "$env:USERPROFILE\OneDrive - Sarpsborg kommune\Skrivebord\Matrikkelklient-1.1.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.Save()

}
    
##Check if "OneDrive is installed"
    if( -Not (Test-Path -Path "$env:USERPROFILE\OneDrive - Sarpsborg kommune" ) )
{
    $TargetFile =  "$Env:USERPROFILE\AppData\Local\Kartverket\Matrikkel\Matrikkelklient-1.1\matrikkelklient.exe"
    $ShortcutFile = "$env:USERPROFILE\Desktop\Matrikkelklient-1.1.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.Save()   
}

##Create Detection Method for SCCM##
					
New-Item -Path $RegistryPath -ErrorAction SilentlyContinue -Force -Verbose
New-ItemProperty    -Path $RegistryPath `
                    -Name $RegistryName `
                    -Value $RegistryValue `
                    -PropertyType String `
                    -Force | Out-Null


##Stop Logging##
Stop-Transcript