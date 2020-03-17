$Dir1  = 'E:\Logs$'
$limit = (Get-Date).AddDays(-120)

Get-ChildItem $Dir1 -Recurse | ? {
  $_.CreationTime -lt $limit
} | Remove-Item -Recurse

