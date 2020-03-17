##Variabler##
$LogPath = 'C:\Windows\Temp\'                
$RegistryPath = "HKCU:\SOFTWARE\Sarpsborg kommune\Matrikkel" #Pek til ønsket lokasjon i registry
##Start Logging##
Start-Transcript -Path $LogPath

##RemoveFiles##

Remove-item -Path $Env:USERPROFILE\AppData\Local\Kartverket\Matrikkel\Matrikkelklient-1.1 -Recurse -Force -Verbose

##DeleteShortcut##
if( (Test-Path -Path "$env:USERPROFILE\OneDrive - Sarpsborg kommune" ) )
{
    Remove-Item -Path "$env:USERPROFILE\OneDrive - Sarpsborg kommune\Skrivebord\Matrikkelklient-1.1.lnk" -Verbose -Force
}
    
##Check if "OneDrive is installed"
    if( -Not (Test-Path -Path "$env:USERPROFILE\OneDrive - Sarpsborg kommune" ) )
{
   Remove-Item $env:USERPROFILE\Desktop\Matrikkelklient-1.1.lnk -Force -Verbose  
}

##Create Detection Method for SCCM##
					
Remove-Item -Path $RegistryPath -ErrorAction SilentlyContinue -Force -Verbose

##Stop Logging##
Stop-Transcript