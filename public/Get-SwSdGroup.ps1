function Get-SwSDGroup {
	<#
	.SYNOPSIS
		Returns the group record for the specified group name.
	.DESCRIPTION
		Returns the group record for the specified group name or all groups.
	.PARAMETER Name
		The group name. If not specified, returns all groups.
	.EXAMPLE
		Get-SwSDGroup -Name "Admins"
		Returns information for the Admins group.
	.EXAMPLE
		Get-SwSDGroup
		Returns all groups.
	#>
	[CmdletBinding()]
	param(
		[parameter()][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$url     = Get-SwSDAPI -Name "Groups List"
		$url     = "$($url)?per_page=100"
		$groups  = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
		if (![string]::IsNullOrEmpty($Name)) {
			$groups | Where-Object {$_.name -eq $Name}
		} else {
			$groups
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}
