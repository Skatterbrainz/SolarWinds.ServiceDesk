function Remove-SwSdTask {
	<#
	.SYNOPSIS
		Deletes the task for the specified Task URL.
	.DESCRIPTION
		Deletes the task for the specified Task URL.
	.PARAMETER TaskURL
		The URL of the task.
	.EXAMPLE
		Remove-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
		Deletes the specified incident task record.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Task
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Remove-SwSdTask.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$TaskURL
	)
	$Session  = Connect-SwSD
	$response = Invoke-RestMethod -Method DELETE -Uri $TaskURL -Headers $Session.headers
	$response
}
