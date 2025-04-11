function Get-SwSdRole {
	<#
	.SYNOPSIS
		Returns the role record for the specified role name.
	.DESCRIPTION
		Returns the role record for the specified role name or all roles.
	.PARAMETER Name
		The role name. If not specified, returns all roles.
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
	param(
		[parameter(Mandatory = $False)][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSdAPI -Name "Roles List"
		$url     = "$($baseurl)?per_page=100"
		$roles   = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
		if (![string]::IsNullOrEmpty($Name)) {
			$roles | Where-Object {$_.name -eq $Name}
		} else {
			$roles
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}