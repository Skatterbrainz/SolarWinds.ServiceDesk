function Get-SwSdTask {
	<#
	.SYNOPSIS
		Returns the Service Desk task records for the specified Task URL or Incident Number.
	.DESCRIPTION
		Returns the Service Desk task records for the specified Task URL or Incident Number.
	.PARAMETER TaskURL
		The URL of the task. If provided, returns the specific task record.
	.PARAMETER IncidentNumber
		The incident number. If provided without TaskURL, returns all task records for the specified incident.
	.EXAMPLE
		Get-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
		Returns the task record for the specified Task URL.
	.EXAMPLE
		Get-SwSdTask -IncidentNumber "12345"
		Returns the task records for the Incident record having the number 12345.
	.NOTES
		If both TaskURL and IncidentNumber are provided, TaskURL takes precedence.
		Returns an error if neither TaskURL nor IncidentNumber is provided.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdTask.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$TaskURL,
		[parameter(Mandatory = $False)][string]$IncidentNumber
	)
	try {
		if ([string]::IsNullOrEmpty($TaskURL) -and [string]::IsNullOrEmpty($IncidentNumber)) {
			throw "Either the TaskURL or IncidentNumber must be provided."
		}
		$Session = Connect-SwSD
		if (![string]::IsNullOrWhiteSpace($TaskURL)) {
			$response = Invoke-RestMethod -Method GET -Uri $TaskURL.Trim() -Headers $Session.headers | Select-Object -ExpandProperty task
		} elseif (![string]::IsNullOrWhiteSpace($IncidentNumber)) {
			$incident = Get-SwSdIncident -Number $IncidentNumber
			if ($null -ne $incident) {
				$response = @()
				$tasks = $incident.tasks
				Write-Verbose "$($tasks.Count) tasks found for Incident $IncidentNumber."
				foreach ($task in $tasks) {
					$TaskURL = $task.href
					Write-Verbose "Task URL: $taskUrl"
					$response += Invoke-RestMethod -Method GET -Uri $TaskURL -Headers $Session.headers | Select-Object -ExpandProperty task
				}
			} else {
				throw "Incident $IncidentNumber not found."
			}
		} else {
			throw "Either the TaskURL or IncidentNumber must be provided."
		}
	} catch {
		Write-Error $_.Exception.Message
	} finally {
		$response
	}
}
