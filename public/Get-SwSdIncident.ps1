function Get-SwSdIncident {
	<#
	.SYNOPSIS
		Returns a Service Desk incident or list of incidents.
	.DESCRIPTION
		Returns a Service Desk incident for the specified incident Number or ID + name.
		If Number and Id are not provided, it returns a list of incidents.
		When requesting a list of incidents, the status and name can be used to filter the results.
		By default, it returns 100 records per page. The maximum number of pages is 0 (all pages).
	.PARAMETER Number
		The incident number.
	.PARAMETER Id
		The incident ID.
	.PARAMETER Name
		The incident name. Required if Id is provided.
	.PARAMETER Status
		The status of the incident, for example "Pending Assignment", "Assigned", "Closed", etc.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER PageCount
		The number of pages to return. Default is 0 (all pages).
	.EXAMPLE
		Get-SwSdIncident -Number 12345
		Returns the incident record for incident number 12345.
	.EXAMPLE
		Get-SwSdIncident -Id 123456789 -Name "Incident Name"
		Returns the incident record for incident ID 12345 with the specified name.
	.EXAMPLE
		Get-SwSdIncident -Status "Pending Assignment" -Name "Incident Name"
		Returns a list of incidents with status "Pending Assignment" and name "Incident Name".
	.EXAMPLE
		Get-SwSdIncident -Status "Pending Assignment" -PageLimit 50 -PageCount 2
		Returns a list of incidents with status "Pending Assignment", with a maximum of 50 records per page, and returns 2 pages.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Incident
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdIncident.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Number,
		[parameter(Mandatory = $False)][int32]$Id,
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Status,
		[parameter(Mandatory = $False)][int]$PageLimit = 100,
		[parameter(Mandatory = $False)][int]$PageCount = 0
	)
	try {
		if (![string]::IsNullOrWhiteSpace($Number)) {
			Write-Verbose "Search by Number"
			$baseurl = getApiBaseURL -ApiName "Search"
			$url = "$($baseurl)?q=number:$Number"
			Write-Verbose "url = $url"
			$result = getApiResponseByURL -URL $url
		} elseif (![string]::IsNullOrWhiteSpace($Id) -and ![string]::IsNullOrWhiteSpace($Name)) {
			Write-Verbose "Search by Id and Name"
			$idx = Get-SwSdIncidentLink -Number $Id -Name $Name
			$url = getApiBaseURL -ApiName "Helpdesk Incidents List" -NoExtension
			$url = "$url/$idx"
			Write-Verbose "url = $url"
			$result = getApiResponseByURL -URL $url
		} elseif (![string]::IsNullOrWhiteSpace($Status) -and ![string]::IsNullOrWhiteSpace($Name)) {
			Write-Verbose "Search by Status and Name"
			$baseurl = getApiBaseURL -ApiName "Search"
			$searchCriteria = "state:`"$($Status)`" AND name:`"$($Name)`""
			$encodedSearch  = [System.Web.HttpUtility]::UrlEncode($searchCriteria)
			$url = "$($baseurl)?per_page=$PageLimit&q=$($encodedSearch)"
			Write-Verbose "url: $url"
			$result = @()
			$response = Invoke-WebRequest -Uri $url -Headers $SDSession.headers -Method Get -ErrorAction Stop -ContentType "application/json"
			$result += $response.Content | ConvertFrom-Json
			Write-Verbose "$($result.Count) incidents returned."
			if ($response.Headers) {
				Write-Verbose "getting response headers"
				[int]$totalCount = $response.Headers['X-Total-Count'][0]
				[int]$totalPages = $response.Headers['X-Total-Pages'][0]
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
					$totalPages = $PageCount
				}
				for ($i = 2; $i -le $totalPages; $i++) {
					$pageurl = "$url&page=$i"
					Write-Verbose "url: $pageurl"
					$response = Invoke-WebRequest -Uri $pageurl -Headers $SDSession.headers -Method Get -ErrorAction Stop -ContentType "application/json"
					if ($response) {
						$result += $response.Content | ConvertFrom-Json
						Write-Verbose "$($result.Count) incidents returned."
					} else {
						Write-Error "Failed to retrieve incident data. Status Code: $($response.StatusCode)"
						continue
					}
				}
			}
		} elseif (![string]::IsNullOrWhiteSpace($Status)) {
			Write-Verbose "Search by Status"
			$baseurl = getApiBaseURL -ApiName "Helpdesk Incidents List"
			$url = "$($baseurl)?per_page=$PageLimit&state=$Status"
			Write-Verbose "url: $url"
			$response = Invoke-WebRequest -Uri $url -Headers $SDSession.headers -Method Get -ContentType "application/json" -ErrorAction Stop
			if ($response.StatusCode -eq 200) {
				$result = $response.Content | ConvertFrom-Json
				Write-Verbose "$($result.Count) incidents returned."
				[int]$totalCount = $response.Headers['X-Total-Count'][0]
				[int]$totalPages = $response.Headers['X-Total-Pages'][0]
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
					$totalPages = $PageCount
				}
				for ($i = 2; $i -le $totalPages; $i++) {
					$pageurl = "$url&page=$i"
					Write-Verbose "url: $pageurl"
					$response = Invoke-WebRequest -Uri $pageurl -Headers $SDSession.headers -Method Get -ContentType "application/json" -ErrorAction Stop
					if ($response.StatusCode -eq 200) {
						$result += $response.Content | ConvertFrom-Json
						Write-Verbose "$($result.Count) incidents returned."
					} else {
						Write-Error "Failed to retrieve incident data. Status Code: $($response.StatusCode)"
						continue
					}
				}
			} else {
				Write-Error "Failed to retrieve incident data. Status Code: $($response.StatusCode)"
				return
			}
			Write-Verbose "$($result.Count) incidents returned."
		}
	} catch {
		$result = [pscustomobject]@{
			Status    = 'Error'
			Activity  = $($_.CategoryInfo.Activity -join (";"))
			Message   = $($_.Exception.Message -join (";"))
			Trace     = $($_.ScriptStackTrace -join (";"))
			Incident  = $IncidentNumber
		}
	} finally {
		$result
	}
}