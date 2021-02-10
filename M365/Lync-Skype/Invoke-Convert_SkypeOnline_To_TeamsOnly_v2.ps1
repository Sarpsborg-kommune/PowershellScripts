
##Step 1: Login to skype-online module ##
Import-PSSession (New-CsOnlineSession -OverrideAdminDomain sarpsborgkommune.onmicrosoft.com) -AllowClobber

##Step 2: Get Users based on OU ##
$OU = ''
$USER = Get-ADUser -Filter * -SearchBase $OU | Select-Object -ExpandProperty UserPrincipalName
$Time = Get-Date

Write-Host $USER 

##Step 3: Convert User To Teams Only ##
foreach ($person in $USER) {
    
    $TeamsUpgrade = Get-CsOnlineUser -Identity $person | Select-Object -ExpandProperty TeamsUpgradeEffectiveMode
    
    if ( $TeamsUpgrade -notlike "TeamsOnly" ) {

        Grant-CsTeamsUpgradePolicy -Identity $person -PolicyName UpgradeToTeams
        Write-Host $person moved to  $TeamsUpgrade : $Time -Verbose -BackgroundColor Black -ForegroundColor Green
    }
    else {
        Write-Host "No action performed on $person, User already set to $TeamsUpgrade" -BackgroundColor Black -ForegroundColor Red
    }
 }

## Step 4: Export user status to webiste
foreach ($person in $USER) {
    
    $TeamsStatus = Get-CsOnlineUser -Identity $person | Select-Object DisplayName, UserPrincipalName, TeamsUpgradeEffectiveMode
$TeamsStatus

}

Get-CsOnlineUser TeamsUpgradeEffectiveMode

  
