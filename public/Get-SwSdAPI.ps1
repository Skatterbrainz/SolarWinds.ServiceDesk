function Get-SwSDAPI {
	<#
	.DESCRIPTION
		Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.
		Caches list to global variable $SDAPIList, to minimize API calls.
	.PARAMETER Name
		The name of the API to retrieve. If not specified, returns the list of available APIs.
	.EXAMPLE
		Get-SwSDAPI -Name "Incidents List"
		Returns the URL for the Incidents List API
	.EXAMPLE
		Get-SwSDAPI
		Returns all API URLs
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$Name
	)
	$Session = Connect-SwSD
	if (!$SDAPIList) {
		Write-Verbose "API list not cached"
		$url = "$($Session.apiurl)/api.json"
		Write-Verbose "Url = $url"
		$apilist = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		if ($apilist.Count -gt 0) {
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
