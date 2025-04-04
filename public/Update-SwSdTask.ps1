function Update-SwSDTask {
	<#
	.DESCRIPTION
		Updates the specified task record with the provided assignee and/or status.
	.PARAMETER TaskURL
		The URL of the task.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Completed
		Mark the task as completed.
	.EXAMPLE
		Update-SwSDTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Completed
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$TaskURL,
		[parameter()][string][Alias('Email')]$Assignee,
		[parameter()][switch]$Completed
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