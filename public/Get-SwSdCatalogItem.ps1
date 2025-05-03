function Get-SwSdCatalogItem {
	<#
	.SYNOPSIS
		Returns the catalog item records for the specified ID or all catalog items.
	.DESCRIPTION
		Returns the catalog item records for the specified ID or all catalog items.
	.PARAMETER Id
		The catalog item ID.
	.PARAMETER Name
		The catalog item name.
	.PARAMETER Tag
		The catalog item tag.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.EXAMPLE
		Get-SwSdCatalogItem -Id 12345
		
		Returns the catalog item record for the specified ID.
	.EXAMPLE
		Get-SwSdCatalogItem -Name "New User"

		Returns the catalog item record for the specified name.
	.EXAMPLE
		Get-SwSdCatalogItem -Tag "New User"

		Returns the catalog item record for the specified tag.
	.EXAMPLE
		Get-SwSdCatalogItem -PageLimit 50

		Returns a list of catalog items with a maximum of 50 records per page.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCatalogItem.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Tag,
		[parameter(Mandatory = $False)][int]$PageLimit = 100
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSdAPI -Name "Catalog Items List"
		if (![string]::IsNullOrEmpty($Id)) {
			$url = getApiBaseURL -ApiName "Catalog Items List"
			$url = "$url/$Id.json"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		} elseif (![string]::IsNullOrEmpty($Name) -and ($Id -gt 0)) {
			$url = getApiBaseURL -ApiName "Catalog Items List"
			$url = "$url/$Id-$($Name.ToLower().Replace(' ','-')).json"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		} else {
			$url = "$($baseurl)?per_page=$PageLimit"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop -ResponseHeadersVariable responseHeaders
			Write-Verbose "$($result.Count) items returned."
			if ($responseHeaders) {
				[int]$totalCount = $responseHeaders.'X-Total-Count'[0]
				[int]$totalPages = $responseHeaders.'X-Total-Pages'[0]
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				for ($i = 2; $i -le $totalPages; $i++) {
					Write-Progress -Activity "Retrieving Catalog Items" -Status "Page $i of $totalPages" -PercentComplete ($i / $totalPages * 100) -Id 0
					$url = "$($baseurl)?per_page=$PageLimit&page=$i"
					$result += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
				}
				Write-Progress -Activity "Retrieving Catalog Items" -Status "Completed" -PercentComplete 100 -Id 0
			} else {
				Write-Warning "No pages returned."
			}
		}
		Write-Output $result
	} catch {
		Write-Error $_.Exception.Message
	}
}