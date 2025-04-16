function New-SwSdTask {
	<#
	.SYNOPSIS
		Creates a new task for the specified incident number.
	.DESCRIPTION
		Creates a new task for the specified incident number. 
		The task is assigned to the specified user and has a due date offset by the specified number of days.
	.PARAMETER IncidentNumber
		The incident number.
	.PARAMETER Name
		The task name.
	.PARAMETER Assignee
		The task assignee email address.
	.PARAMETER IsComplete
		The task completion status. Default is False.
	.PARAMETER DueDateOffsetDays
		The number of days to offset the due date. Default is 14 days.
	.EXAMPLE
		New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com"
	.NOTES
		Refer to https://apidoc.samanage.com/#tag/Task/operation/createTask
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdTask.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$IncidentNumber,
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$Name,
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$Assignee,
		[parameter(Mandatory = $False)][boolean]$IsComplete = $False,
		[parameter(Mandatory = $False)][int]$DueDateOffsetDays = 7
	)
	try {
		$Session  = Connect-SwSD
		$incident = Get-SwSdIncident -Number $IncidentNumber
		if (!$incident) { throw "Incident $IncidentNumber not found." }
		$baseurl = Get-SwSdAPI -Name "Helpdesk Incidents List"
		$url  = "$($baseurl.replace('.json',''))/$($incident.id)/tasks"
		Write-Verbose "Tasks URL: $url"
		Write-Verbose "Verifying User $Assignee"
		$user = Get-SwSdUser -Email $Assignee
		if (!$user) {
			throw "User $Assignee not found."
		}
		$dueDate = (Get-Date).AddDays($DueDateOffsetDays).ToString("MMM dd, yyyy")
		$body = @{
			"task" = @{
				"name" = $Name.Trim()
				"assignee" = @{
					"email" = $Assignee.Trim()
				}
				"due_at" = $dueDate
				"is_complete" = $IsComplete
			}
		} | ConvertTo-Json
		Write-Verbose "Creating task: $json"
		#curl -H "X-Samanage-Authorization: Bearer $token" -H "Accept: application/vnd.samanage.v2.1+json" -H "Content-Type: application/json" -X POST $url -d $json
		$response = Invoke-RestMethod -Method POST -Uri $url -ContentType "application/json" -Headers $Session.headers -Body $body #-ErrorAction Stop
		$response
	} catch {
		if ($_.Exception.Message -notmatch '406') {
			Write-Error $_.Exception.Message
		}
	}
}
