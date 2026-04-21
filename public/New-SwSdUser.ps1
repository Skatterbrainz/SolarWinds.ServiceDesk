function New-SwSdUser {
	<#
	.SYNOPSIS
		Creates a new user in SolarWinds Service Desk.
	.DESCRIPTION
		Creates a new user in SolarWinds Service Desk with the specified parameters.
	.PARAMETER Name
		Required. The full name of the user.
	.PARAMETER Email
		Required. The email address of the user.
	.PARAMETER Role
		Optional. The role of the user. Example: "Agent", "Requester", "Admin"
	.PARAMETER ReportsTo
		Optional. The email address of the user's manager. Example: "manager@example.com"
	.PARAMETER Phone
		Optional. The phone number of the user. Example: "+1-555-555-5555"
	.PARAMETER MobilePhone
		Optional. The mobile phone number of the user. Example: "+1-555-555-5555"
	.PARAMETER Department
		Optional. The department of the user. Example: "IT", "HR", "Finance"
	.PARAMETER Site
		Optional. The site of the user. Example: "New York", "London", "Tokyo"
	.EXAMPLE
		New-SwSdUser -Name "John Doe" -Email "john.doe@example.com" -Role "Agent"
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/User/operation/createUser
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdUser.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	param (
		[parameter(Mandatory = $True)][string]$Name,
		[parameter(Mandatory = $True)][string]$Email,
		[parameter(Mandatory = $False)][string]$Role,
		[parameter(Mandatory = $False)][string]$ReportsTo,
		[parameter(Mandatory = $False)][string]$Phone,
		[parameter(Mandatory = $False)][string]$MobilePhone,
		[parameter(Mandatory = $False)][string]$Department,
		[parameter(Mandatory = $False)][string]$Site
	)
	try {
		$body = @{
			user = @{
				name = $Name
				email = $Email
			}
		}
		if (![string]::IsNullOrEmpty($Role)) {
			# validate role exists before creating user
			if (Get-SwSdRole -Name $Role) {
				$body.user.role = $Role
			} else {
				Write-Warning "Role '$Role' does not exist. User will be created without a role."
			}
		} else {
			Write-Verbose "No role specified. User will be created without a role."
		}
		if (![string]::IsNullOrEmpty($ReportsTo)) {
			# validate manager email exists before creating user
			if (Get-SwSdUser -Email $ReportsTo) {
				$body.user.reports_to = $ReportsTo
			} else {
				Write-Warning "Manager with email '$ReportsTo' does not exist. User will be created without a manager."
			}
		} else {
			Write-Verbose "No manager specified. User will be created without a manager."
		}
		if (![string]::IsNullOrEmpty($Phone)) {
			$body.user.phone = $Phone
		}
		if (![string]::IsNullOrEmpty($MobilePhone)) {
			$body.user.mobile_phone = $MobilePhone
		}
		if (![string]::IsNullOrEmpty($Department)) {
			# validate department exists before creating user
			if (Get-SwSdDepartment -Name $Department) {
				$body.user.department = $Department
			} else {
				Write-Warning "Department '$Department' does not exist. User will be created without a department."
			}
		} else {
			Write-Verbose "No department specified. User will be created without a department."
		}
		if (![string]::IsNullOrEmpty($Site)) {
			# validate site exists before creating user
			if (Get-SwSdSite -Name $Site) {
				$body.user.site = $Site
			} else {
				Write-Warning "Site '$Site' does not exist. User will be created without a site."
			}
		} else {
			Write-Verbose "No site specified. User will be created without a site."
		}
		$body = $body | ConvertTo-Json -Depth 10
		Write-Verbose "Request body: $body"
		$SDSession = Connect-SwSD
		$url = getApiBaseURL -ApiName "Users List"
		Write-Verbose "API URL: $url"
		$invokeWebRequestParams = @{
			Uri             = $url
			Headers         = $SDSession.headers
			Method          = 'Post'
			Body            = $body
			UseBasicParsing = $true
		}
		$result = Invoke-SwSdWebRequest @invokeWebRequestParams

		Write-Verbose "User created with status code: $($result.StatusCode)"
		if ($result.StatusCode -eq 201) {
			Write-Output $($result.Content | ConvertFrom-Json)
		} else {
			Write-Warning "Failed to create user. Status code: $($result.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}