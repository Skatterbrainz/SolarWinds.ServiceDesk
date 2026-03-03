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
		$hardware = getApiListOrItem -ApiName "Computers List" -Id $Id -PerPage 100
		if (![string]::IsNullOrEmpty($Name)) {
			$hardware | Where-Object { $_.name -eq $Name }
		} else {
			$hardware
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