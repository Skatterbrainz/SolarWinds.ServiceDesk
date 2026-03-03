function Get-SwSdUser {
	<#
	.SYNOPSIS
		Returns the Service Desk user records for the specified email or ID.
	.DESCRIPTION
		Returns the Service Desk user records for the specified email or ID, or all users.
	.PARAMETER Email
		The user email address. If provided, returns matching user records.
	.PARAMETER Id
		The user ID. If provided, returns the specific user record.
	.EXAMPLE
		Get-SwSdUser -Email "jsmith@contoso.com"
		
		Returns the user record for the specified email address.
	.EXAMPLE
		Get-SwSdUser -Id 12345

		Returns the user record for the specified ID.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/User
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdUsers', 'Get-SwSdUserList')]
	param(
		[parameter(Mandatory = $False)][Alias('Name')][string]$Email,
		[parameter(Mandatory = $False)][string]$Id
	)
	try {
		$users = getApiListOrItem -ApiName "Users List" -Id $Id -PerPage 100
		if (![string]::IsNullOrEmpty($Email)) {
			$users | Where-Object { $_.email -eq $Email }
		} else {
			$users
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