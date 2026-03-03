function Get-SwSdCategory {
	<#
	.SYNOPSIS
		Retrieves a list of categories from SolarWinds Service Desk.
	.DESCRIPTION
		Retrieves a list of categories from SolarWinds Service Desk.
	.PARAMETER Name
		Optional. The name of the category to retrieve. If not specified, retrieves all categories.
	.PARAMETER Id
		Optional. The ID of the category to retrieve. If not specified, retrieves all categories.
	.EXAMPLE
		Get-SwSdCategory
		
		Retrieves a list of categories from SolarWinds Service Desk.
	.EXAMPLE
		Get-SwSdCategory -Name "Software"
		
		Retrieves the category with the name "Software" from SolarWinds Service Desk.
	.EXAMPLE
		Get-SwSdCategory -Id 12345

		Retrieves the category with the ID 12345 from SolarWinds Service Desk.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Category
		Reference: https://apidoc.samanage.com/#tag/Category/operation/getCategoryById
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCategory.md
	#>
	[CmdletBinding()]
    param (
        [parameter(Mandatory = $False)][string]$Name,
        [parameter(Mandatory = $False)][string]$Id
    )
	try {
		$categories = getApiListOrItem -ApiName "Categories List" -Id $Id -PerPage 100
		if (![string]::IsNullOrEmpty($Name)) {
			$categories | Where-Object {$_.name -eq $Name}
		} else {
			$categories
		}
	} catch {
		[pscustomobject]@{
			Status    = 'Error'
			Activity  = $($_.CategoryInfo.Activity -join (";"))
			Message   = $($_.Exception.Message -join (";"))
			Trace     = $($_.ScriptStackTrace -join (";"))
			Incident  = $IncidentNumber
		}
	}
}