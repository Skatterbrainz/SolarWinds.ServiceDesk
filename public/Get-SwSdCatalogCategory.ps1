function Get-SwSDCatalogCategory {
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
		Get-SwSDCatalogCategories
		Returns the catalog categories.
	.EXAMPLE
		Get-SwSDCatalogCategory -Id 12345
		Returns the catalog category for the specified ID.
	.EXAMPLE
		Get-SwSDCatalogCategory -Name "Mobile Devices"
		Returns the catalog category for the specified name.
	#>
	[CmdletBinding()]
	param(
		[parameter()][int]$Id,
		[parameter()][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$url     = Get-SwSDAPI -Name "Categories List"
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