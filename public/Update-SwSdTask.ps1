function Update-SwSdTask {
	<#
	.SYNOPSIS
		Updates the specified task record with the provided assignee and/or status.
	.DESCRIPTION
		Updates the specified task record with the provided assignee and/or status.
		You can specify either the assignee or status, or both.
		Assignee must be a valid SWSD user account.
	.PARAMETER TaskURL
		The URL of the task.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Completed
		Mark the task as completed.
	.EXAMPLE
		Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Completed
		Updates the task record for the specified Task URL and marks it as completed.
	.EXAMPLE
		Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Assignee "jsmith@contoso.com"
		Updates the task record for the specified Task URL and assigns it to the specified user.
	.NOTES
		The Assignee must be a valid SWSD user account.
		Reference: https://apidoc.samanage.com/#tag/Task
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdTask.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$TaskURL,
		[parameter(Mandatory = $False)][string][Alias('Email')]$Assignee,
		[parameter(Mandatory = $False)][switch]$Completed
	)
	$Session = Connect-SwSD
	$task    = Invoke-RestMethod -Method GET -Uri $TaskURL -Headers $Session.headers
	if ($task) {
		$body    = @{task = @{}}
		if (![string]::IsNullOrEmpty($Assignee)) {
			$body.task.assignee = @{email = $Assignee}
		}
		if ($Completed.IsPresent) {
			$body.task.is_complete = $true
		}
		$json = $body | ConvertTo-Json
		$response = Invoke-RestMethod -Method PUT -Uri $TaskURL -ContentType "application/json" -Headers $Session.headers -Body $json
		$response
	} else {
		Write-Error "Task not found with URL: $TaskURL"
	}
}