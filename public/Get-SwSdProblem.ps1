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
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdProblems', 'Get-SwSdProblemList')]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][string]$Status,
		[parameter(Mandatory = $False)][string]$Priority,
		[parameter(Mandatory = $False)][string]$HREF
	)
	try {
		if (![string]::IsNullOrWhiteSpace($Id)) {
			getApiListOrItem -ApiName "Problems List" -Id $Id
		} elseif (![string]::IsNullOrWhiteSpace($Name)) {
			$problems = getApiListOrItem -ApiName "Problems List" -PerPage 100 -QueryParameters @{ name = $Name }
			$problems | Where-Object { $_.name -eq $Name }
		} elseif (![string]::IsNullOrWhiteSpace($Status)) {
			$problems = getApiListOrItem -ApiName "Problems List" -PerPage 100 -QueryParameters @{ state = $Status }
			$problems | Where-Object { $_.state -eq $Status }
		} elseif (![string]::IsNullOrWhiteSpace($Priority)) {
			$problems = getApiListOrItem -ApiName "Problems List" -PerPage 100 -QueryParameters @{ priority = $Priority }
			$problems | Where-Object { $_.priority -eq $Priority }
		} elseif (![string]::IsNullOrWhiteSpace($HREF)) {
			$problems = getApiListOrItem -ApiName "Problems List" -PerPage 100 -QueryParameters @{ href = $HREF }
			$problems | Where-Object { $_.href -eq $HREF }
		} else {
			getApiListOrItem -ApiName "Problems List" -PerPage 100 -AllPages
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}