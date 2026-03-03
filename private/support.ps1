function getApiBaseURL {
	<#
	.SYNOPSIS
		Returns the base URL for the specified API.
	.DESCRIPTION
		Returns the base URL for the specified API. If no API name is specified, it returns all APIs.
	.PARAMETER ApiName
		The name of the API to retrieve the base URL for. If not specified, returns all APIs.
	.PARAMETER NoExtension
		If specified, removes the ".json" extension from the returned URL.
	.EXAMPLE
		getApiBaseURL -ApiName "Audit Log List"
		Returns the base URL for the "Audit Log List" API (e.g. "https://api.samanage.com/audits.json").
	.EXAMPLE
		getApiBaseURL -ApiName "Audit Log List" -NoExtension
		Returns the base URL for the "Audit Log List" API without the ".json" extension. (e.g. "https://api.samanage.com/audits").
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][Alias('Name')][string]$ApiName,
		[parameter(Mandatory = $False)][switch]$NoExtension
	)
	$SDSession = Connect-SwSD
	$url = Get-SwSdAPI -Name $ApiName
	if (![string]::IsNullOrEmpty($url)) {
		if ($NoExtension.IsPresent) {
			Write-Output $url.Replace(".json","")
		} else {
			Write-Output $url
		}
	} else {
		Write-Error "API URL not found for $ApiName"
	}
}

function getApiResponse {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string]$ApiName,
		[parameter(Mandatory = $False)][ValidateSet('Default','Delete','Get','Head','Merge','Options','Patch','Post','Put','Trace')][string]$Method = 'GET',
		[parameter(Mandatory = $False)][string]$ContentType = 'application/json'
	)
	$url = getApiBaseURL -ApiName $ApiName
	Write-Verbose "API=$ApiName > URL=$url"
	$params = @{
		Uri             = $url.Trim()
		Method          = $Method
		ContentType     = $ContentType
		Headers         = $SDSession.headers
		UseBasicParsing = $true
		ErrorAction	    = 'Stop'
	}
	$response = Invoke-WebRequest @params
	if ($response.StatusCode -eq 200) {
		Write-Output $($response.Content | ConvertFrom-Json)
	} else {
		Write-Warning "Failed to retrieve $ApiName. Status code: $($response.StatusCode)"
	}
}

function getApiResponseByURL {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string]$URL,
		[parameter(Mandatory = $False)][ValidateSet('Default','Delete','Get','Head','Merge','Options','Patch','Post','Put','Trace')][string]$Method = 'GET',
		[parameter(Mandatory = $False)][string]$ContentType = 'application/json',
		[parameter(Mandatory = $False)][string]$Body
	)
	$SDSession = Connect-SwSD
	$params = @{
		Uri             = $URL.Trim()
		Method          = $Method
		ContentType     = $ContentType
		Headers         = $SDSession.headers
		UseBasicParsing = $true
	}
	if ($Method -eq 'POST' -or $Method -eq 'PUT') {
		$params.Body = $Body
	}
	$response = Invoke-WebRequest @params
	#$response = Invoke-RestMethod -Method $Method -Uri $URL.Trim() -Headers $Session.headers
	if ($response.StatusCode -eq 200) {
		if ($response.Content) {
			Write-Output $($response.Content | ConvertFrom-Json)
		} else {
			Write-Output $response
		}
	} else {
		Write-Warning "Failed to retrieve data from URL. Status code: $($response.StatusCode)"
	}
}

function getApiListOrItem {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string]$ApiName,
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][int]$PerPage = 100,
		[parameter(Mandatory = $False)][hashtable]$QueryParameters,
		[parameter(Mandatory = $False)][switch]$NoIdExtension
	)
	$SDSession = Connect-SwSD
	if (![string]::IsNullOrEmpty($Id)) {
		$baseurl = getApiBaseURL -ApiName $ApiName -NoExtension
		if ($NoIdExtension.IsPresent) {
			$url = "$($baseurl)/$Id"
		} else {
			$url = "$($baseurl)/$Id.json"
		}
	} else {
		$baseurl = getApiBaseURL -ApiName $ApiName
		$queryPairs = @()
		if ($PerPage -gt 0) {
			$queryPairs += "per_page=$PerPage"
		}
		if ($QueryParameters) {
			foreach ($key in $QueryParameters.Keys) {
				if (![string]::IsNullOrEmpty($QueryParameters[$key])) {
					$queryPairs += "$key=$($QueryParameters[$key])"
				}
			}
		}
		if ($queryPairs.Count -gt 0) {
			$url = "$($baseurl)?$($queryPairs -join '&')"
		} else {
			$url = $baseurl
		}
	}
	Write-Verbose "URL: $url"
	$params = @{
		Uri             = $url
		Method          = 'Get'
		Headers         = $SDSession.headers
		ErrorAction     = 'Stop'
		UseBasicParsing = $true
	}
	Write-Verbose "Getting data for '$ApiName' with parameters: $($params | Out-String)"
	Invoke-WebRequest @params | Select-Object -ExpandProperty Content | ConvertFrom-Json
}