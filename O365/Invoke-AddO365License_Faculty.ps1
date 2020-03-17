Import-Module ActiveDirectory
$groupname = 'NAME OF AD GRP'
$users = Get-ADUser -Filter * -SearchBase "LINK TO OU"
foreach($user in $users)
{
  Add-ADGroupMember -Identity $groupname -Members $user.samaccountname -ErrorAction SilentlyContinue
}
  
$members = Get-ADGroupMember -Identity $groupname
foreach($member in $members)
{
  if($member.distinguishedname -notlike "*LINK TO OU*")
  {
    Remove-ADGroupMember -Identity $groupname -Member $member.samaccountname -Confirm:$false
  }
}
