$Dir1  = 'C:\InetPub\Logs\LogFiles\W3SVC1'
$Dir2  = 'C:\InetPub\Logs\LogFiles\W3SVC309241794'
$limit = (Get-Date).AddDays(-30)

Get-ChildItem $Dir1 -Recurse | ? {
  -not $_.PSIsContainer -and $_.CreationTime -lt $limit
} | Remove-Item

Get-ChildItem $Dir2 -Recurse | ? {
  -not $_.PSIsContainer -and $_.CreationTime -lt $limit
} | Remove-Item
