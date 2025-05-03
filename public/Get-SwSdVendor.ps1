function Get-SwSdVendor {
	<#
	.SYNOPSIS
		Returns the Service Desk vendor records for the specified ID or all vendors.
	.DESCRIPTION
		Returns the Service Desk vendor records for the specified ID or all vendors.
	.PARAMETER Name
		The vendor name to search for. If provided, returns the specific vendor record.
	.PARAMETER Id
		The vendor ID. If provided, returns the specific vendor record.
	.EXAMPLE
		Get-SwSdVendor -Name "Vendor1"

		Returns the vendor record for the specified name.
	.EXAMPLE
		Get-SwSdVendor -Id "12345"

		Returns the vendor record for the specified ID.
	.EXAMPLE
		Get-SwSdVendor
		
		Returns all vendor records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdVendor.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id
	)
	try {
		$vendors = getApiResponse -ApiName "Vendors List"
		if ($vendors) {
			if (![string]::IsNullOrWhiteSpace($Name)) {
				$vendors | Where-Object { $_.name -eq $Name -or $_.id -eq $Name }
			} elseif (![string]::IsNullOrWhiteSpace($Id)) {
				$vendors | Where-Object { $_.id -eq $Id }
			} else {
				return $vendors
			}
		} else {
			throw "Failed to retrieve vendors. Status code: $($response.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}