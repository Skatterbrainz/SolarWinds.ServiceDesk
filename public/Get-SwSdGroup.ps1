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
		$groups  = Invoke-WebRequest @params | Select-Object -ExpandProperty Content | ConvertFrom-Json
		if (![string]::IsNullOrEmpty($Name)) {
			$groups | Where-Object {$_.name -eq $Name}
		} elseif ($Id) {
			$groups | Where-Object {$_.id -eq $Id}
		} else {
			$groups
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
