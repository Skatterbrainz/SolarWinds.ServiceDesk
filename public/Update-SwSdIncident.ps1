function Update-SwSDIncident {
	<#
	.DESCRIPTION
		Updates the specified incident record with the provided assignee and/or status.
	.PARAMETER Number
		The incident number.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Status
		The status of the incident: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled.
		The default status is 'Assigned'.
	.EXAMPLE
		Update-SwSDIncident -Number 12345 -Assignee "jsmith@contoso.org" -Status "Pending Assignment"
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter()][string][Alias('Email')]$Assignee,
		[parameter()][string][ValidateSet('Awaiting Input','Assigned','Closed','On Hold','Pending Assignment','Scheduled')][Alias('State')]$Status = 'Pending Assignment'
	)
	try {
		if ([string]::IsNullOrEmpty($Assignee) -and [string]::IsNullOrEmpty($Status)) {
			throw "Assignee or Status must be provided."
		}
		$Session = Connect-SwSD
		Write-Verbose "Requesting Incident $Number"
		$incident = Get-SwSDIncident -Number $Number -NoRequestData
		if (!$incident) {
			throw "Incident $Number not found."
		}
		$msg = ""
		$body = @{incident = @{}}

		if (![string]::IsNullOrEmpty($Status)) {
			$msg += "Status: $($Status.Trim())"
			$body.incident.state = "$($Status.Trim())"
		}
		if (![string]::IsNullOrEmpty($Assignee)) {
			Write-Verbose "Verifying User $Assignee"
			$user = Get-SwSDUser -Email $Assignee
			if (!$user) {
				throw "User $Assignee not found."
			}
			$msg += "Assignee: $($Assignee.Trim())"
			$body.incident.assignee = @{
				email = "$($Assignee.Trim())"
			}
		}
		$json = $body | ConvertTo-Json
		Write-Verbose "Updating incident at URL: $($incident.href)"
		$response = Invoke-RestMethod -Method PUT -Uri $($incident.href) -ContentType "application/json" -Headers $Session.headers -Body $json
		Write-Verbose "Incident $Number updated: $($response.state)"
		$result = [pscustomobject]@{
			Status   = "Success"
			State    = $Status
			Assignee = $Assignee
		}
	} catch {
		$result = [pscustomobject]@{
			Status   = "Error"
			Activity = $($_.CategoryInfo.Activity -join (";"))
			Message  = $($_.Exception.Message -join (";"))
			Trace    = $($_.ScriptStackTrace -join (";"))
		}
	} finally {
		$result
	}
}
