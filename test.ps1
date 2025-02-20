Import-Module '/home/ds0934/Documents/GitHub/SolarWinds.ServiceDesk/SolarWinds.ServiceDesk.psm1' -Force

$svcAccount = "svc_ULMAPI@AdvocatesInc.org"

$token = Get-Content ~/sdtoken.txt
New-SDSession -ApiToken $token

$incident = Get-SDIncident -Number 54833
$incident | Select-Object id,number,name,state,requestType

Get-SDUser -Email $svcAccount

New-SDTask -IncidentNumber 54833 -Name "Test Return Laptop" -Assignee $svcAccount -Verbose
New-SDTask -IncidentNumber 54833 -Name "Test Return Monitor" -Assignee $svcAccount -Verbose
New-SDTask -IncidentNumber 54833 -Name "Test Return Phone" -Assignee $svcAccount -Verbose

$tasks = $incident = Get-SDIncident -Number 54833 | Select-Object -ExpandProperty tasks
$newTask = $tasks.href | sort-object | select-object -Last 1

Update-SDTask -TaskURL $newTask -Assignee $svcAccount