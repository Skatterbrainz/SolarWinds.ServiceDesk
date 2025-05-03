function Get-SwSdPrinter {
	<#
	.SYNOPSIS
		Returns the Service Desk printer records for the specified ID or all printers.
	.DESCRIPTION
		Returns the Service Desk printer records for the specified ID or all printers.
	.PARAMETER Name
		The printer name. If provided, returns the specific printer record.
	.PARAMETER Id
		The printer ID. If provided, returns the specific printer record.
	.EXAMPLE
		Get-SwSdPrinter -Name "Printer1"

		Returns the printer record for the specified name.
	.EXAMPLE
		Get-SwSdPrinter -Id "12345"

		Returns the printer record for the specified ID.
	.EXAMPLE
		Get-SwSdPrinter
		
		Returns all printer records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPrinter.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id
	)
	try {
		$printers = getApiResponse -ApiName "Other Assets List"
		if ($printers) {
			if (![string]::IsNullOrWhiteSpace($Name)) {
				$printers | Where-Object { $_.name -eq $Name -or $_.id -eq $Name }
			} elseif (![string]::IsNullOrWhiteSpace($Id)) {
				$printers | Where-Object { $_.id -eq $Id }
			} else {
				return $printers
			}
		} else {
			throw "Failed to retrieve printers. Status code: $($response.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}