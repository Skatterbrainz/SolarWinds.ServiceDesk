function Get-SwSdDepartment {
	<#
	.SYNOPSIS
		Returns the Service Desk department records for the specified ID or all departments.
	.DESCRIPTION
		Returns the Service Desk department records for the specified ID or all departments.
	.PARAMETER Name
		The department name or ID. If provided, returns the specific department record.
	.EXAMPLE
		Get-SwSdDepartment -Name "IT"

		Returns the department record for the specified name.
	.EXAMPLE
		Get-SwSdDepartment -Name "12345"

		Returns the department record for the specified ID.
	.EXAMPLE
		Get-SwSdDepartment
		
		Returns all department records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdDepartment.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Name
	)
	try {
		$departments = getApiResponse -ApiName "Departments List"
		if ($departments) {
			if (![string]::IsNullOrWhiteSpace($Name)) {
				$departments | Where-Object { $_.name -eq $Name -or $_.id -eq $Name -or $_.description -match $Name}
			} else {
				return $departments
			}
		} else {
			throw "Failed to retrieve departments. Status code: $($response.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}