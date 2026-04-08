function Get-SwSdPrinter {
	<#
	.SYNOPSIS
		Returns the Service Desk printer records for the specified ID or all printers.
	.DESCRIPTION
		Returns the Service Desk printer records for the specified ID or all printers.
	.PARAMETER Name
		The printer name. If provided, returns the specific printer record.
	.PARAMETER Id
		The printer ID. If provided, returns the specific printer record.
	.EXAMPLE
		Get-SwSdPrinter -Name "Printer1"

		Returns the printer record for the specified name.
	.EXAMPLE
		Get-SwSdPrinter -Id "12345"

		Returns the printer record for the specified ID.
	.EXAMPLE
		Get-SwSdPrinter
		
		Returns all printer records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPrinter.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdPrinters', 'Get-SwSdPrinterList')]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Id
	)
	try {
		if (![string]::IsNullOrEmpty($Id)) {
			getApiListOrItem -ApiName "Printers List" -Id $Id
		} elseif (![string]::IsNullOrEmpty($Name)) {
			$printers = getApiListOrItem -ApiName "Printers List" -PerPage 100 -QueryParameters @{ name = $Name }
			$printers | Where-Object { $_.name -eq $Name }
		} else {
			getApiListOrItem -ApiName "Printers List" -PerPage 100 -AllPages
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