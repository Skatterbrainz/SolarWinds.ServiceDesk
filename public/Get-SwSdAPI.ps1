function Get-SwSdAPI {
	<#
	.SYNOPSIS
		Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.
	.DESCRIPTION
		Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.
		Caches list to global variable $SDAPIList, to minimize API calls.
	.PARAMETER Name
		The name of the API to retrieve. If not specified, returns the list of available APIs.
	.PARAMETER Force
		Force refresh of the API list from the API, instead of using cached list.
	.EXAMPLE
		Get-SwSdAPI -Name "Incidents List"
		Returns the URL for the Incidents List API
	.EXAMPLE
		Get-SwSdAPI
		Returns all API URLs
	.EXAMPLE
		Get-SwSdAPI -Name "Search"
		Returns the URL for the Search API
	.EXAMPLE
		Get-SwSdAPI -Name "Search" -Force
		Returns the URL for the Search API, forcing refresh of the API list from the API, instead of using cached list.
	.NOTES
		Reference: https://apidoc.samanage.com/#section/General-Concepts/API-Entry-Point

		name                     href
		----                     ----
		Computers List           https://api.samanage.com/hardwares.json
		Helpdesk Incidents List  https://api.samanage.com/incidents.json
		Risks List               https://api.samanage.com/risks.json
		Contracts List           https://api.samanage.com/contracts.json
		Software List            https://api.samanage.com/softwares.json
		Other Assets List        https://api.samanage.com/other_assets.json
		Vendors List             https://api.samanage.com/vendors.json
		Printers List            https://api.samanage.com/printers.json
		Audit Log List           https://api.samanage.com/audits.json
		Users List               https://api.samanage.com/users.json
		Problems List            https://api.samanage.com/problems.json
		Changes List             https://api.samanage.com/changes.json
		Releases List            https://api.samanage.com/releases.json
		Solutions List           https://api.samanage.com/solutions.json
		Catalog Items List       https://api.samanage.com/catalog_items.json
		Departments List         https://api.samanage.com/departments.json
		Sites List               https://api.samanage.com/sites.json
		Groups List              https://api.samanage.com/groups.json
		Mobile Devices List      https://api.samanage.com/mobiles.json
		Roles List               https://api.samanage.com/roles.json
		Categories List          https://api.samanage.com/categories.json
		Change Catalogs List     https://api.samanage.com/change_catalogs.json
		Configuration Items List https://api.samanage.com/configuration_items.json
		Purchase Orders List     https://api.samanage.com/purchase_orders.json

		Appended with search API
		Search                    https://api.samanage.com/search.json
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAPI.md
	#>
	[CmdletBinding()]
	[OutputType([string], [PSCustomObject])]
	param (
		[parameter(Mandatory = $false)][string]$Name,
		[parameter(Mandatory = $false)][switch]$Force
	)
	$SDSession = Connect-SwSD
	if (!$SDAPIList -or $Force) {
		Write-Verbose "API list not cached or force refresh requested, retrieving from API"
		$url = "$($SDSession.apiurl)/api.json"
		Write-Verbose "Url = $url"
		$apilist = @((Invoke-WebRequest -Uri $url -Headers $SDSession.headers -Method Get -ErrorAction Stop).Content | ConvertFrom-Json)
		if ($apilist.Count -gt 0) {
			Write-Verbose "API list returned $($apilist.Count) API endpoints"
			# the search api is not included in the list for some reason, so append it manually
			$apilist += @([pscustomobject]@{name='Search'; href='https://api.samanage.com/search.json'})
		}
		$global:SDAPIList = $apilist
	} else {
		Write-Verbose "API list cached"
	}
	if (![string]::IsNullOrEmpty($Name)) {
		$SDAPIList | Where-Object {$_.name -eq $Name} | Select-Object -ExpandProperty href
	} else {
		$SDAPIList
	}
}
