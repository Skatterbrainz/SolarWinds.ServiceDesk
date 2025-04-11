function Get-SwSDIncident {
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
		Get-SwSDIncident -Number 12345
		Returns the incident record for incident number 12345.
	.EXAMPLE
		Get-SwSDIncident -Id 123456789 -Name "Incident Name"
		Returns the incident record for incident ID 12345 with the specified name.
	.EXAMPLE
		Get-SwSDIncident -Status "Pending Assignment" -Name "Incident Name"
		Returns a list of incidents with status "Pending Assignment" and name "Incident Name".
	.EXAMPLE
		Get-SwSDIncident -Status "Pending Assignment" -PageLimit 50 -PageCount 2
		Returns a list of incidents with status "Pending Assignment", with a maximum of 50 records per page, and returns 2 pages.
	.NOTES
	.LINK
		
	#>
	[CmdletBinding()]
	param (
		[parameter(ParameterSetName='Number')][string]$Number,
		[parameter(ParameterSetName='ID')][int32]$Id,
		[parameter(ParameterSetName='ID')][string]$Name,
		[parameter()][string]$Status,
		[parameter()][int]$PageLimit = 100,
		[parameter()][int]$PageCount = 0
	)
	try {
		$Session  = Connect-SwSD
		if (![string]::IsNullOrEmpty($Number)) {
			$baseurl = Get-SwSDAPI -Name "Search"
			$url = "$($baseurl)?q=number:$Number"
			Write-Verbose "url = $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
		} elseif (![string]::IsNullOrEmpty($Id) -and ![string]::IsNullOrEmpty($Name)) {
			$baseurl = Get-SwSDAPI -Name "Helpdesk Incidents List"
			$idx = Get-SwSDIncidentLink -Number $Id -Name $Name
			$url = "$($baseurl.Replace('.json',''))/$idx"
			Write-Verbose "url = $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get	
		} else {
			$baseurl = Get-SwSDAPI -Name "Search"
			if ([string]::IsNullOrEmpty($baseurl)) { throw "API Url not found." }
			$searchCriteria = "state:`"$($Status)`" AND name:`"$($Name)`""
			$encodedSearch  = [System.Web.HttpUtility]::UrlEncode($searchCriteria)
			$url = "$($baseurl)?per_page=$PageLimit&q=$($encodedSearch)"
			Write-Verbose "url: $url"
			$incidents = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
			if ($responseHeaders) {
				Write-Verbose "getting response headers"
				[int]$totalCount = $responseHeaders.'X-Total-Count'
				[int]$totalPages = $responseHeaders.'X-Total-Pages'
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
					$totalPages = $PageCount
				}
				for ($i = 2; $i -le $totalPages; $i++) {
					$url = "$url&page=$i"
					Write-Verbose "url: $url"
					$incidents += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
				}
			}
			$result = $incidents	
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