#    Get-Content '\\fil104\d$\gat\Gatsoft\Import\vismalog.txt' -Credential {Get-Credential}  | select -last 15
#    Get-Content '\\prog701\c$\scripts\logs\norconsult.log' | select -last 5
#   Script lister de siste linjer i GAT-import og ISY-export

    $c = Get-Credential
    $s = New-PSSession -ComputerName fil104 -Credential $c
    Invoke-Command -Session $s -ScriptBlock {Get-Content 'd:\gat\gatsoft\import\vismalog.txt' | select -last 8}

    $s = New-PSSession -ComputerName prog701 -Credential $c
    Invoke-Command -Session $s -ScriptBlock {Get-Content 'c:\scripts\logs\norconsult.log' | select -last 2}
