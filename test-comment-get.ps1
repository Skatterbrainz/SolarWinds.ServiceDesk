function Get-SDComments {
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$IncidentNumber
	)
	$Session     = New-SDSession
	$incident    = Get-SDIncident -Number $IncidentNumber -NoRequestData
	$incURL      = (Get-SDAPI -Name "Helpdesk Incidents List") -replace ".json", ""
	$commentsUrl = "$($incURL)/$($incident.id)/comments.json"
	$response    = Invoke-RestMethod -Method GET -Uri $commentsUrl -ContentType "application/json" -Headers $Session.headers
	$response
}

Get-SDComments -IncidentNumber 54833 | select id,user,created_at,body | ft -AutoSize