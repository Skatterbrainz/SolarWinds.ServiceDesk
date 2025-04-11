function Get-SwSdGroup {
	<#
	.SYNOPSIS
		Returns the group record for the specified group name.
	.DESCRIPTION
		Returns the group record for the specified group name or all groups.
	.PARAMETER Name
		The group name. If not specified, returns all groups.
	.EXAMPLE
		Get-SwSdGroup -Name "Admins"
		Returns information for the Admins group.
	.EXAMPLE
		Get-SwSdGroup
		Returns all groups.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Group
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdGroup.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $False)][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$url     = Get-SwSdAPI -Name "Groups List"
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
