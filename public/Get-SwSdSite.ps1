function Get-SwSdSite {
	<#
	.SYNOPSIS
		Returns the Service Desk site records for the specified ID or all sites.
	.DESCRIPTION
		Returns the Service Desk site records for the specified ID or all sites.
	.PARAMETER Name
		The site name or ID. If provided, returns the specific site record.
	.EXAMPLE
		Get-SwSdSite -Name "Main Office"
		
		Returns the site record for the specified name.
	.EXAMPLE
		Get-SwSdSite -Name "12345"

		Returns the site record for the specified ID.
	.EXAMPLE
		Get-SwSdSite

		Returns all site records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdSite.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $False)][string]$Name
	)
	try {
		$sites = getApiResponse -ApiName "Other Assets List"
		if ($sites) {
			if (![string]::IsNullOrWhiteSpace($Name)) {
				$sites | Where-Object { $_.name -eq $Name -or $_.id -eq $Name}
			} else {
				return $sites
			}
		} else {
			throw "Failed to retrieve sites. Status code: $($response.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}