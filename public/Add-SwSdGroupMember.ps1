function Add-SwSdGroupMember {
	<#
	.SYNOPSIS
		Adds a user to a specified group in SolarWinds Service Desk.
	.DESCRIPTION
		Adds a user to a specified group in SolarWinds Service Desk by making an API call to the appropriate endpoint.
	.PARAMETER GroupName
		The name of the group to which the user will be added.
	.PARAMETER UserEmail
		The email address of the user to be added to the group. The user must already exist in the Service Desk system.
		Multiple names or email addresses can be specified by separating them with commas.
	.EXAMPLE
		Add-SwSdGroupMember -GroupName "Admins" -UserEmail "user1@example.com"

		Adds the user with email
	.EXAMPLE
		Add-SwSdGroupMember -GroupName "Admins" -UserEmail "user1@example.com,user2@example.com"

		Adds the users with email addresses
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Add-SwSdGroupMember.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	param (
		[parameter(Mandatory = $true)][string]$GroupName,
		[parameter(Mandatory = $true)][string]$UserEmail
	)
	try {
		$baseurl = getApiBaseURL -ApiName "Groups List"
		$url = "$($baseurl)?per_page=100"
		$params = @{
			Uri             = $url
			Method          = 'Get'
			Headers         = $SDSession.headers
			ErrorAction     = 'Stop'
			UseBasicParsing = $true
		}
		Write-Verbose "Getting groups with parameters: $($params | Out-String)"
		$group = Get-SwSdGroup -Name $GroupName
		if ($group) {
			foreach ($email in $UserEmail.Split(",")) {
				$email = $email.Trim()
				$user = Get-SwSdUser -Email $email
				if ($user) {
					$url = "https://api.samanage.com/memberships.xml?group_id=$($group.id)&user_ids=$($user.id)"
					$params = @{
						Uri             = $url
						Method          = 'Post'
						Headers         = $SDSession.headers
						ErrorAction     = 'Stop'
						UseBasicParsing = $true
					}
					Write-Verbose "Adding user $email to group $GroupName with parameters: $($params | Out-String)"
					try {
						$response = Invoke-WebRequest @params
						#Write-Verbose "Response: $($response.Content)"
						if ($response.StatusCode -eq 200) {
							Write-Verbose "User $email added to group $GroupName successfully."
						} else {
							Write-Warning "Failed to add user $email to group $($GroupName). Status code: $($response.StatusCode)"
						}
					} catch {
						Write-Warning "Error adding user $email to group $($GroupName): $($_.Exception.Message)"
					}
				} else {
					Write-Warning "User with email $email not found, skipping."
				}
			}
		}
	} catch {
		[pscustomobject]@{
			Status    = 'Error'
			Activity  = $($_.CategoryInfo.Activity -join (";"))
			Message   = $($_.Exception.Message -join (";"))
			Trace     = $($_.ScriptStackTrace -join (";"))
			Incident  = $IncidentNumber
		}
	}
}