function New-SwSdTask {
	<#
	.DESCRIPTION
		Creates a new task for the specified incident number.
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
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$IncidentNumber,
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Name,
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Assignee,
		[parameter()][boolean]$IsComplete = $False,
		[parameter()][int]$DueDateOffsetDays = 14
	)
	try {
		$Session  = Connect-SwSD
		$incident = Get-SwSDIncident -Number $IncidentNumber
		if (!$incident) { throw "Incident $IncidentNumber not found." }
		$baseurl = Get-SwSDAPI -Name "Helpdesk Incidents List"
		$url  = "$($baseurl.replace('.json',''))/$($incident.id)/tasks"
		Write-Verbose "Tasks URL: $url"
		Write-Verbose "Verifying User $Assignee"
		$user = Get-SwSDUser -Email $Assignee
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
