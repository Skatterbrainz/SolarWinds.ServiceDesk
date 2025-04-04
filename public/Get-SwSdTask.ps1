function Get-SwSdTask {
	<#
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
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$TaskURL,
		[parameter()][string]$IncidentNumber
	)
	try {
		if ([string]::IsNullOrEmpty($TaskURL) -and [string]::IsNullOrEmpty($IncidentNumber)) {
			throw "Either the TaskURL or IncidentNumber must be provided."
		}
		$Session = Connect-SwSD
		if (![string]::IsNullOrWhiteSpace($TaskURL)) {
			$response = Invoke-RestMethod -Method GET -Uri $TaskURL.Trim() -Headers $Session.headers
		} elseif (![string]::IsNullOrWhiteSpace($IncidentNumber)) {
			$incident = Get-SwSDIncident -Number $IncidentNumber -NoRequestData
			if ($null -ne $incident) {
				$response = @()
				$tasks = $incident.tasks
				Write-Verbose "$($tasks.Count) tasks found for Incident $IncidentNumber."
				foreach ($task in $tasks) {
					$TaskURL = $task.href
					Write-Verbose "Task URL: $taskUrl"
					$response += Invoke-RestMethod -Method GET -Uri $TaskURL -Headers $Session.headers
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
