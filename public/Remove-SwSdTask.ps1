function Remove-SwSdTask {
	<#
	.DESCRIPTION
		Deletes the task for the specified Task URL.
	.PARAMETER TaskURL
		The URL of the task.
	.EXAMPLE
		Remove-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
		Deletes the specified incident task record.
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$TaskURL
	)
	$Session  = Connect-SwSD
	$response = Invoke-RestMethod -Method DELETE -Uri $TaskURL -Headers $Session.headers
	$response
}
