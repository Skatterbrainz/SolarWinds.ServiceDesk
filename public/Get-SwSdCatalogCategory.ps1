function Get-SwSdCatalogCategory {
	<#
	.SYNOPSIS
		Returns a catalog category or returns all categories.
	.DESCRIPTION
		Returns a catalog category or returns all categories.
	.PARAMETER Id
		The catalog category ID.
	.PARAMETER Name
		The catalog category name.
	.EXAMPLE
		Get-SwSdCatalogCategories
		Returns the catalog categories.
	.EXAMPLE
		Get-SwSdCatalogCategory -Id 12345
		Returns the catalog category for the specified ID.
	.EXAMPLE
		Get-SwSdCatalogCategory -Name "Mobile Devices"
		Returns the catalog category for the specified name.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Category
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCatalogCategory.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $False)][int]$Id,
		[parameter(Mandatory = $False)][string]$Name
	)
	try {
		$url = getApiBaseURL -ApiName "Categories List"
		Write-Verbose "Url: $url"
		$response = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop | Sort-Object name
		if ($Id -gt 0) {
			$response | Where-Object {$_.id -eq $Id}
		} elseif (![string]::IsNullOrEmpty($Name)) {
			$response | Where-Object {$_.name -eq $Name}
		} else {
			$response
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}