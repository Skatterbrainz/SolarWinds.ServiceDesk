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
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdVendors', 'Get-SwSdVendorList', 'Get-SDVendor')]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id
	)
	try {
		if (![string]::IsNullOrWhiteSpace($Id)) {
			getApiListOrItem -ApiName "Vendors List" -Id $Id
		} elseif (![string]::IsNullOrWhiteSpace($Name)) {
			$vendors = getApiListOrItem -ApiName "Vendors List" -PerPage 100 -QueryParameters @{ name = $Name }
			$vendors | Where-Object { $_.name -eq $Name }
		} else {
			getApiListOrItem -ApiName "Vendors List" -PerPage 100 -AllPages
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}