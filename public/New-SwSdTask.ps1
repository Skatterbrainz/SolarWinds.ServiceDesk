function New-SwSdTask {
	<#
	.SYNOPSIS
		Creates a new task for the specified incident number.
	.DESCRIPTION
		Creates a new task for the specified incident number. 
		The task is assigned to the specified user and can have a due date and completion status.
		Use the -IsComplete parameter to set the task as complete.
	.PARAMETER IncidentNumber
		The incident number.
	.PARAMETER Name
		The task name or description.
	.PARAMETER Assignee
		The task assignee email address. Must be a valid Service Desk user or group.
	.PARAMETER IsComplete
		The task completion status. True indicates a completed task. The default is False.
	.PARAMETER DueDate
		The due date for the task. Default is no due date.
	.EXAMPLE
		New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com"

		Add a task for "Task Name" assigned to user "user123@contoso.com" with no due date.
	.EXAMPLE
		New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com" -DueDate "2025-12-31"

		Add a task for "Task Name" assigned to user "user123@contoso.com" with a due date of "2025-12-31".
	.EXAMPLE
		New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com" -IsComplete $True

		Add a task for "Task Name" assigned to user "user123@contoso.com" with a completion status of $True.
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
		[parameter(Mandatory = $False)][datetime]$DueDate
	)
	try {
		$incident = Get-SwSdIncident -Number $IncidentNumber
		if (!$incident) { throw "Incident $IncidentNumber not found." }
		$url = getApiBaseURL -ApiName "Helpdesk Incidents List" -NoExtension
		$url  = "$url/$($incident.id)/tasks"
		Write-Verbose "Tasks URL: $url"
		Write-Verbose "Verifying User $Assignee"
		$user = Get-SwSdUser -Email $Assignee
		if (!$user) {
			throw "User $Assignee not found."
		}
		if (![string]::IsNullOrEmpty($DueDate)) {
			$dueDate = (Get-Date $DueDate).ToString("MMM dd, yyyy")
			Write-Verbose "Due Date: $dueDate"
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
		} else {
			$body = @{
				"task" = @{
					"name" = $Name.Trim()
					"assignee" = @{
						"email" = $Assignee.Trim()
					}
					"is_complete" = $IsComplete
				}
			} | ConvertTo-Json
		}
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
