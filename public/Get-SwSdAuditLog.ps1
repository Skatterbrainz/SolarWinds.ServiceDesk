function Get-SwSdAuditLog {
	<#
	.SYNOPSIS
		Returns the Service Desk audit log records for the specified ID or all audit logs.
	.DESCRIPTION
		Returns the Service Desk audit log records for the specified ID or all audit logs.
	.PARAMETER Id
		The audit log ID. If provided, returns the specific audit log record.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER Limit
		The maximum number of records to return. Default is 100.
	.EXAMPLE
		Get-SwSdAuditLog -Id 12345
		
		Returns the audit log record for the specified ID.
	.EXAMPLE
		Get-SwSdAuditLog -PageLimit 50

		Returns a list of audit logs with a maximum of 50 records per page.
	.EXAMPLE
		Get-SwSdAuditLog -Limit 200

		Returns a list of audit logs with a maximum of 200 records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAuditLog.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][int]$PageLimit = 100,
		[parameter(Mandatory = $False)][int]$Limit = 100
	)
	try {
		if (![string]::IsNullOrEmpty($Id)) {
			$url = getApiBaseURL -ApiName "Audit Log List" -NoExtension
			$url = "$url/$Id.json"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		} else {
			$baseurl = getApiBaseURL -ApiName "Audit Log List"
			$url = "$($baseurl)?per_page=$PageLimit"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop -ResponseHeadersVariable responseHeaders
			Write-Verbose "$($result.Count) items returned."
			if ($responseHeaders) {
				[int]$totalCount = $responseHeaders.'X-Total-Count'[0]
				[int]$totalPages = $responseHeaders.'X-Total-Pages'[0]
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				while ($result.Count -lt $Limit -and $totalPages -gt 1) {
					$PageLimit = $Limit - $result.Count
					if ($PageLimit -le 0) {
						break
					}
					Write-Progress -Activity "Retrieving Audit Logs" -Status "Page 1 of $totalPages" -PercentComplete (1 / $totalPages * 100) -Id 0
					$url = "$($baseurl)?per_page=$PageLimit&page=1"
					$result += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
					$totalPages--
				}
				if ($totalPages -gt 1) {
					Write-Progress -Activity "Retrieving Audit Logs" -Status "Page 2 of $totalPages" -PercentComplete (2 / $totalPages * 100) -Id 0
					$url = "$($baseurl)?per_page=$PageLimit&page=2"
					$result += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
				}
				$totalPages--
			}
		}
	} catch {
		Write-Error $_.Exception.Message
	} finally {
		Write-Output $result
	}
}