function Get-SwSDRole {
	<#
	.SYNOPSIS
		Returns the role record for the specified role name.
	.DESCRIPTION
		Returns the role record for the specified role name or all roles.
	.PARAMETER Name
		The role name. If not specified, returns all roles.
	.EXAMPLE
		Get-SwSDRole -Name "Admin"
		Returns information for the Admin role.
	.EXAMPLE
		Get-SwSDRole
		Returns all roles.
	#>
	[CmdletBinding()]
	param(
		[parameter()][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSDAPI -Name "Roles List"
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