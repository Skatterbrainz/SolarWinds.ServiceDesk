function Update-SwSdIncident {
	<#
	.SYNOPSIS
		Updates the specified incident record with the provided assignee and/or status.
	.DESCRIPTION
		Updates the specified incident record with the provided assignee and/or status.
		You can specify either the assignee or status, or both.
		Assignee must be a valid SWSD user account.
	.PARAMETER Number
		The incident number.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Status
		The status of the incident: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled.
		The default status is 'Assigned'.
	.EXAMPLE
		Update-SwSdIncident -Number 12345 -Assignee "jsmith@contoso.org" -Status "Pending Assignment"
		Updates the incident 12345 with the specified assignee 'jsmith@contoso.org' and status 'Pending Assignment'.
	.EXAMPLE
		Update-SwSdIncident -Number 12345 -Status "Closed"
		Updates the incident 12345 with the specified status 'Closed'
	.NOTES
		The Assignee must be a valid SWSD user account.
		Reference: https://apidoc.samanage.com/#tag/Incident
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdIncident.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter(Mandatory = $False)][string][Alias('Email')]$Assignee,
		[parameter(Mandatory = $False)][string][Alias('State')]$Status
	)
	try {
		if ([string]::IsNullOrEmpty($Assignee) -and [string]::IsNullOrEmpty($Status)) {
			throw "Assignee or Status must be provided."
		}
		$Session = Connect-SwSD
		Write-Verbose "Requesting Incident $Number"
		$incident = Get-SwSdIncident -Number $Number -NoRequestData
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
			$user = Get-SwSdUser -Email $Assignee
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
