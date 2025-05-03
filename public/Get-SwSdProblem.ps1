function Get-SwSdProblem {
	<#
	.SYNOPSIS
		Returns the Service Desk problem records for the specified criteria or all problems.
	.DESCRIPTION
		Returns the Service Desk problem records for the specified criteria or all problems.
	.PARAMETER Name
		The problem name or ID. If provided, returns the specific problem record.
	.PARAMETER Id
		The problem ID. If provided, returns the specific problem record.
	.PARAMETER Status
		The problem status. If provided, returns the specific problem record.
	.PARAMETER Priority
		The problem priority. If provided, returns the specific problem record.
	.PARAMETER HREF
		The problem HREF. If provided, returns the specific problem record.
	.EXAMPLE
		Get-SwSdProblem -Name "Network Issue"
		
		Returns the problem record for the specified name.
	.EXAMPLE
		Get-SwSdProblem -Id "12345"

		Returns the problem record for the specified ID.
	.EXAMPLE
		Get-SwSdProblem -Status "Open"

		Returns the problem records for the specified status.
	.EXAMPLE
		Get-SwSdProblem -Priority "High"

		Returns the problem records for the specified priority.
	.EXAMPLE
		Get-SwSdProblem -HREF "https://api.samanage.com/problem/1234567890"

		Returns the problem record for the specified HREF.
	.EXAMPLE
		Get-SwSdProblem

		Returns all problem records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdProblem.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][string]$Status,
		[parameter(Mandatory = $False)][string]$Priority,
		[parameter(Mandatory = $False)][string]$HREF
	)
	try {
		$problems = getApiResponse -ApiName "Other Assets List"
		if ($problems) {
			if (![string]::IsNullOrWhiteSpace($Name)) {
				$problems | Where-Object { $_.name -eq $Name -or $_.id -eq $Name }
			} elseif (![string]::IsNullOrWhiteSpace($Id)) {
				$problems | Where-Object { $_.id -eq $Id }
			} elseif (![string]::IsNullOrWhiteSpace($Status)) {
				$problems | Where-Object { $_.state -eq $Status }
			} elseif (![string]::IsNullOrWhiteSpace($Priority)) {
				$problems | Where-Object { $_.priority -eq $Priority }
			} elseif (![string]::IsNullOrWhiteSpace($HREF)) {
				$problems | Where-Object { $_.href -eq $HREF }
			} else {
				return $problems
			}
		} else {
			throw "Failed to retrieve problems. Status code: $($response.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}