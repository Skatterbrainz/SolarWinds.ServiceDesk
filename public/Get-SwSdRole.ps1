function Get-SwSdRole {
	<#
	.SYNOPSIS
		Returns the role record for the specified role name.
	.DESCRIPTION
		Returns the role record for the specified role name or all roles.
	.PARAMETER Name
		The role name. If not specified, returns all roles.
	.PARAMETER Id
		The role ID. If provided, returns the specific role record.
	.EXAMPLE
		Get-SwSdRole -Name "Admin"

		Returns information for the Admin role.
	.EXAMPLE
		Get-SwSdRole

		Returns all roles.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Role
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdRole.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdRoles', 'Get-SwSdRoleList', 'Get-SDRole')]
	param(
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id
	)
	try {
		if (![string]::IsNullOrEmpty($Id)) {
			getApiListOrItem -ApiName "Roles List" -Id $Id
		} elseif (![string]::IsNullOrEmpty($Name)) {
			$roles = getApiListOrItem -ApiName "Roles List" -PerPage 100 -QueryParameters @{ name = $Name }
			$roles | Where-Object {$_.name -eq $Name}
		} else {
			getApiListOrItem -ApiName "Roles List" -PerPage 100 -AllPages
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}