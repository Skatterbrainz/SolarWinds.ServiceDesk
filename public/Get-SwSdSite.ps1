function Get-SwSdSite {
	<#
	.SYNOPSIS
		Returns the Service Desk site records for the specified ID or all sites.
	.DESCRIPTION
		Returns the Service Desk site records for the specified ID or all sites.
	.PARAMETER Name
		The site name or ID. If provided, returns the specific site record.
	.PARAMETER Id
		The site ID. If provided, returns the specific site record.
	.EXAMPLE
		Get-SwSdSite -Name "Main Office"
		
		Returns the site record for the specified name.
	.EXAMPLE
		Get-SwSdSite -Id "1234567"

		Returns the site record for the specified ID.
	.EXAMPLE
		Get-SwSdSite

		Returns all site records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdSite.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdSites', 'Get-SwSdSiteList')]
	param(
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id
	)
	try {
		$sites = getApiListOrItem -ApiName "Sites List" -Id $Id -PerPage 100
		if (![string]::IsNullOrEmpty($Name)) {
			$sites | Where-Object { $_.name -eq $Name }
		} else {
			$sites
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}