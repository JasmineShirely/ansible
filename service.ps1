#$SNowUser = "admin"
$Systemid="d1bb7314db311300e25dd450cf9619e2" #Paste the Incident's sys ID
#$SNowPass = ConvertTo-SecureString –String "Tinku123(" –AsPlainText -Force
#$SNowCreds = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $SNowUser, $SNowPass

$user = "admin"
$pass = "Tinku123("
$pair = "$($user):$($pass)"

$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$basicAuthValue = "Basic $encodedCreds"
$Headers = @{
    Authorization = $basicAuthValue
    Accept = "application/json"
}

$jsn = Invoke-RestMethod -method Get -Uri "https://dev36472.service-now.com/api/now/table/incident/$Systemid" -Headers $Headers
#$SNowCreds = get-credential
#connecting to incident
#$jsn = Invoke-RestMethod -Credential $pair  -Headers $headers -Method Get -Uri "https://dev36472.service-now.com/api/now/table/incident/$Systemid"
#extracting values from json
$id = $jsn.result.short_description
#$jsn.result.number
#$id1 = $id -contains 'memory'
write-host "FETCHING TICKET DETAILS FROM SERVICE NOW"
write-host "TICKET DESCRIPTION: $id"
$id1= $id -match 'server build'
"ticket=$id1"| out-file env.properties -encoding ASCII
#$ticket |out-file env.properties -encoding ASCII