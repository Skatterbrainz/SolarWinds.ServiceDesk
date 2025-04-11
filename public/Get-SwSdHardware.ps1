function Get-SwSdHardware {
	<#
	.SYNOPSIS
		Returns the hardware records for the specified ID or all hardware.
	.DESCRIPTION
		Returns the hardware records for the specified ID or all hardware.
	.PARAMETER Id
		The hardware ID.
	.PARAMETER PageCount
		The number of pages to return. Default is 0 (all pages).
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER NoProgress
		Suppress the progress indicator.
	.EXAMPLE
		Get-SwSdHardware -Id 12345
		Returns the hardware record for the specified ID.
	.EXAMPLE
		Get-SwSdHardware -PageCount 5
		Returns the first 5 pages of hardware records.
	.EXAMPLE
		Get-SwSdHardware -PageLimit 50
		Returns a list of hardware records with a maximum of 50 records per page.
	.EXAMPLE
		Get-SwSdHardware -NoProgress
		Returns a list of hardware records without showing the progress indicator.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Hardware
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdHardware.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][int]$PageCount = 0,
		[parameter(Mandatory = $False)][int]$PageLimit = 100,
		[parameter(Mandatory = $False)][switch]$NoProgress
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSdAPI -Name "Computers List"
		if (![string]::IsNullOrEmpty($Id)) {
			$url = "$($baseurl)/$Id.json"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
			Write-Output $hardwares
			break
		} else {
			$url = "$($baseurl)?per_page=$PageLimit"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
			if ($responseHeaders) {
				[int]$totalCount = $responseHeaders.'X-Total-Count'[0]
				[int]$totalPages = $responseHeaders.'X-Total-Pages'[0]
				if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
					$totalPages = $PageCount
				}
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				for ($i = 2; $i -le $totalPages; $i++) {
					$url = "$($baseurl)?per_page=$PageLimit&page=$i"
					try {
						$result += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
						if (!$NoProgress.IsPresent) {
							Write-Progress -Activity "Retrieving hardware" -Status "Page $i of $totalPages ($totalCount total items)" -PercentComplete ($i / $totalPages * 100) -Id 0
						}
					} catch {
						continue
					}
				}
				if (!$NoProgress.IsPresent) {
					Write-Progress -Activity "Retrieving hardware" -Status "Completed" -PercentComplete 100 -Id 0
				}
			}
		}
		Write-Output $result
	} catch {
		Write-Error $_.Exception.Message
	}
}