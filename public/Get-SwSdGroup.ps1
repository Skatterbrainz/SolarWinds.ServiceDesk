function Get-SwSdGroup {
	<#
	.SYNOPSIS
		Returns the group record for the specified group name.
	.DESCRIPTION
		Returns the group record for the specified group name or all groups.
	.PARAMETER Name
		The group name. If not specified, returns all groups.
	.PARAMETER Id
		The group ID. If not specified, returns all groups.
	.EXAMPLE
		Get-SwSdGroup -Name "Admins"

		Returns information for the Admins group.
	.EXAMPLE
		Get-SwSdGroup

		Returns all groups.
	.EXAMPLE
		Get-SwSdGroup -Id 123456

		Returns information for the group with ID 123456.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Group
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdGroup.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdGroups', 'Get-SwSdGroupList')]
	param(
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][int]$Id
	)
	try {
		if (![string]::IsNullOrEmpty($Name)) {
			$groups = getApiListOrItem -ApiName "Groups List" -PerPage 100
			$groups | Where-Object {$_.name -eq $Name}
		} elseif ($Id) {
			getApiListOrItem -ApiName "Groups List" -Id $Id -PerPage 100
		} else {
			getApiListOrItem -ApiName "Groups List" -PerPage 100
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
