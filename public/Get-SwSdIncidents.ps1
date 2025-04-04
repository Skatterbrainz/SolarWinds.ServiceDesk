function Get-SwSDIncidents {
	<#
	.DESCRIPTION
		Returns a list of Service Desk incidents based on the specified request type and status.
	.PARAMETER RequestType
		The type of request: Provision or Termination. Default is Provision.
	.PARAMETER Status
		The status of the request: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled. Default is Pending Assignment.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER PageCount
		The number of pages to return. Default is 0 (all pages).
	.PARAMETER IncidentNameProvision
		The name of the incident for provisioning requests. Default is 'New Users are entered into the IT Authorization Form'.
	.PARAMETER IncidentNameTermination
		The name of the incident for termination requests. Default is 'Employee Terminations'.
	#>
	[CmdletBinding()]
	param (
		[parameter()][string][ValidateSet('Provision','Termination')]$RequestType = "Provision",
		[parameter()][string]
		[ValidateSet('Awaiting Input','Assigned','Closed','On Hold','Pending Assignment','Scheduled')]$Status = 'Pending Assignment',
		[parameter()][int]$PageLimit = 100,
		[parameter()][int]$PageCount = 0
	)
	try {
		$Session = Connect-SwSD	
		$baseurl = Get-SwSDAPI -Name "Search"
		if ([string]::IsNullOrEmpty($baseurl)) { throw "API Url not found." }
		$searchCriteria = "state:`"$($Status)`" AND name:`"$($IncName)`""
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