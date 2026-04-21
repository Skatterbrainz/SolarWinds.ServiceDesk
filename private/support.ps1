function Invoke-SwSdWebRequest {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string]$Uri,
		[parameter(Mandatory = $False)][hashtable]$Headers,
		[parameter(Mandatory = $False)][ValidateSet('Default','Delete','Get','Head','Merge','Options','Patch','Post','Put','Trace')][string]$Method = 'Get',
		[parameter(Mandatory = $False)][string]$ContentType,
		[parameter(Mandatory = $False)]$Body,
		[parameter(Mandatory = $False)][switch]$UseBasicParsing,
		[parameter(Mandatory = $False)][string]$ResponseHeadersVariable
	)

	$params = @{
		Uri = $Uri
	}

	if ($PSBoundParameters.ContainsKey('Headers')) { $params.Headers = $Headers }
	if ($PSBoundParameters.ContainsKey('Method')) { $params.Method = $Method }
	if ($PSBoundParameters.ContainsKey('ContentType')) { $params.ContentType = $ContentType }
	if ($PSBoundParameters.ContainsKey('Body')) { $params.Body = $Body }
	if ($PSBoundParameters.ContainsKey('ResponseHeadersVariable')) { $params.ResponseHeadersVariable = $ResponseHeadersVariable }

	if ($PSBoundParameters.ContainsKey('UseBasicParsing')) {
		$params.UseBasicParsing = [bool]$UseBasicParsing
	} else {
		$params.UseBasicParsing = $true
	}

	if ($PSBoundParameters.ContainsKey('ErrorAction')) {
		$params.ErrorAction = $PSBoundParameters['ErrorAction']
	} else {
		$params.ErrorAction = 'Stop'
	}

	Microsoft.PowerShell.Utility\Invoke-WebRequest @params
}

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
	$response = Invoke-SwSdWebRequest @params
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
	$response = Invoke-SwSdWebRequest @params
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
		[parameter(Mandatory = $False)][switch]$AllPages,
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
	$response = Invoke-SwSdWebRequest @params

	if ($AllPages.IsPresent -and [string]::IsNullOrEmpty($Id) -and -not ($QueryParameters -and $QueryParameters.ContainsKey('page'))) {
		$result = @()
		if ($response.Content) {
			$result += @($response.Content | ConvertFrom-Json)
		}

		[int]$totalPages = 1
		if ($response.Headers -and $response.Headers['X-Total-Pages']) {
			[void][int]::TryParse([string]$response.Headers['X-Total-Pages'][0], [ref]$totalPages)
		}

		if ($totalPages -gt 1) {
			$delimiter = if ($url -like '*?*') { '&' } else { '?' }
			for ($page = 2; $page -le $totalPages; $page++) {
				$pageUrl = "$url$($delimiter)page=$page"
				$pageResponse = Invoke-SwSdWebRequest -Uri $pageUrl -Method 'Get' -Headers $SDSession.headers -ErrorAction 'Stop' -UseBasicParsing:$true
				if ($pageResponse.Content) {
					$result += @($pageResponse.Content | ConvertFrom-Json)
				}
			}
		}

		Write-Output $result
		return
	}

	$response | Select-Object -ExpandProperty Content | ConvertFrom-Json
}