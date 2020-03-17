Import-Module ActiveDirectory
$groupname = 'GG_M365_Lisens_Oppvekst_Ansatte'
$users = Get-ADUser -Filter * -SearchBase "OU=Kommuneområde oppvekst,OU=Sarpsborg kommune,OU=Interne,OU=Alle brukere,DC=sarpsborg,DC=com"
foreach($user in $users)
{
  Add-ADGroupMember -Identity $groupname -Members $user.samaccountname -ErrorAction SilentlyContinue
}
  
$members = Get-ADGroupMember -Identity $groupname
foreach($member in $members)
{
  if($member.distinguishedname -notlike "*OU=Kommuneområde oppvekst,OU=Sarpsborg kommune,OU=Interne,OU=Alle brukere,DC=sarpsborg,DC=com*")
  {
    Remove-ADGroupMember -Identity $groupname -Member $member.samaccountname -Confirm:$false
  }
}