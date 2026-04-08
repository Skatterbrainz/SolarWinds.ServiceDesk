function Get-SwSdHardware {
	<#
	.SYNOPSIS
		Returns the Service Desk hardware records for the specified ID or all hardware.
	.DESCRIPTION
		Returns the Service Desk hardware records for the specified ID or all hardware.
	.PARAMETER Id
		The hardware ID. If provided, returns the specific hardware record.
	.PARAMETER Name
		The hardware name. If provided, returns the specific hardware record.
	.EXAMPLE
		Get-SwSdHardware -Id 12345

		Returns the hardware record for the specified ID.
	.EXAMPLE
		Get-SwSdHardware -Name "Laptop-001"

		Returns the hardware record for the specified name.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Hardware
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdHardware.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdHardwareList')]
	param (
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][string]$Name
	)
	try {
		if (![string]::IsNullOrEmpty($Id)) {
			getApiListOrItem -ApiName "Computers List" -Id $Id
		} elseif (![string]::IsNullOrEmpty($Name)) {
			$hardware = getApiListOrItem -ApiName "Computers List" -PerPage 100 -QueryParameters @{ name = $Name }
			$hardware | Where-Object { $_.name -eq $Name }
		} else {
			getApiListOrItem -ApiName "Computers List" -PerPage 100 -AllPages
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