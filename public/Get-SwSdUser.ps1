function Get-SwSdUser {
	<#
	.SYNOPSIS
		Returns the user record for the specified email address.
	.DESCRIPTION
		Returns the user record for the specified email address. If no email address is specified, it returns all users.
		Supports pagination with a specified page limit and page count.
	.PARAMETER Email
		The user's email address.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER PageCount
		The number of pages to return. Default is 10.
	.PARAMETER NoProgress
		Suppress the progress indicator.
	.EXAMPLE
		Get-SwSdUser -Email "jsmith@contoso.com"
		
		Returns the user record for the specified email address.
	.EXAMPLE
		Get-SwSdUser -PageCount 5

		Returns the first 5 pages of user records.
	.EXAMPLE
		Get-SwSdUser -PageLimit 50

		Returns a list of user records with a maximum of 50 records per page.
	.EXAMPLE
		Get-SwSdUser -NoProgress

		Returns a list of user records without showing the progress indicator.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/User
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $False)][Alias('Name')][string]$Email,
		[parameter(Mandatory = $False)][int]$PageLimit = 100,
		[parameter(Mandatory = $False)][int]$PageCount = 10,
		[parameter(Mandatory = $False)][switch]$NoProgress
	)
	try {
		$baseurl = getApiBaseURL -ApiName "Users List"
		if (![string]::IsNullOrEmpty($Email)) {
			$url = "$($baseurl)?email=$Email"
			$result = getApiResponseByURL -URL $url
		} else {
			$url    = "$($baseurl)?per_page=$PageLimit"
			Write-Verbose "Url: $url"
			$users  = @()
			$response = Invoke-WebRequest -Uri $url -Headers $SDSession.headers -Method Get -ContentType "application/json" -ErrorAction Stop
			if ($response.StatusCode -eq 200) {
				$users += $response.Content | ConvertFrom-Json
			} else {
				Write-Error "Failed to retrieve user data. Status Code: $($response.StatusCode)"
				return
			}
			Write-Verbose "$($users.Count) users returned."
			[int]$totalCount = $response.Headers['X-Total-Count'][0]
			[int]$totalPages = $response.Headers['X-Total-Pages'][0]
			Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
			
			if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
				$totalPages = $PageCount
			}
			
			for ($i = 2; $i -le $totalPages; $i++) {
				$url = "$($baseurl)?per_page=$PageLimit&page=$i"
				if (!$NoProgress.IsPresent) {
					Write-Progress -Activity "Retrieving User Data" -Status "Page $i of $totalPages" -PercentComplete ($i / $totalPages * 100) -Id 0
				}
				$users += getApiResponseByURL -URL $url
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