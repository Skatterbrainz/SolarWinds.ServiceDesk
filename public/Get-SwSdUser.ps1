function Get-SwSDUser {
	<#
	.DESCRIPTION
		Returns the user record for the specified email address.
	.PARAMETER Email
		The user's email address.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER PageCount
		The number of pages to return. Default is 10.
	.PARAMETER NoProgress
		Suppress the progress indicator.
	.EXAMPLE
		Get-SwSDUser -Email "jsmith@contoso.com"
	#>
	[CmdletBinding()]
	param(
		[parameter()][Alias('Name')][string]$Email,
		[parameter()][int]$PageLimit = 100,
		[parameter()][int]$PageCount = 10,
		[parameter()][switch]$NoProgress
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSDAPI -Name "Users List"
		if (![string]::IsNullOrEmpty($Email)) {
			$url    = "$($baseurl)?email=$Email"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		} else {
			$url    = "$($baseurl)?per_page=$PageLimit"
			$users  = @()
			$users  += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
			[int]$totalCount = $responseHeaders.'X-Total-Count'[0]
			[int]$totalPages = $responseHeaders.'X-Total-Pages'[0]
			Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
			if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
				$totalPages = $PageCount
			}
			for ($i = 2; $i -le $totalPages; $i++) {
				$url = "$($baseurl)?per_page=$PageLimit&page=$i"
				if (!$NoProgress.IsPresent) {
					Write-Progress -Activity "Retrieving User Data" -Status "Page $i of $totalPages" -PercentComplete ($i / $totalPages * 100) -Id 0
				}
				$users += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders
			}
			if (!$NoProgress.IsPresent) {
				Write-Progress -Activity "Retrieving User Data" -Status "Completed" -PercentComplete 100 -Id 0
			}
			$result = $users | where-Object {$_.disabled -ne $true}
		}
		Write-Output $result
	} catch {
		Write-Error $_.Exception.Message
	}
}