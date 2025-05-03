function Get-SwSdMobileDevice {
	<#
	.SYNOPSIS
		Returns the Service Desk mobile device records for the specified criteria or all devices.
	.DESCRIPTION
		Returns the Service Desk mobile device records for the specified criteria or all devices.
	.PARAMETER Name
		The mobile device name. If provided, returns the specific device record.
	.PARAMETER Manufacturer
		The mobile device manufacturer. If provided, returns the specific device record.
	.PARAMETER Model
		The mobile device model. If provided, returns the specific device record.
	.PARAMETER SerialNumber
		The mobile device serial number. If provided, returns the specific device record.
	.PARAMETER Id
		The mobile device ID. If provided, returns the specific device record.
	.PARAMETER ServiceProvider
		The mobile device service provider. If provided, returns the specific device record.
	.PARAMETER IMEI
		The mobile device IMEI. If provided, returns the specific device record.
	.PARAMETER HREF
		The mobile device HREF. If provided, returns the specific device record.
	.EXAMPLE
		Get-SwSdMobileDevice -Name "iPhone 12"
		
		Returns the mobile device record for the specified name.
	.EXAMPLE
		Get-SwSdMobileDevice -Manufacturer "Apple"

		Returns the mobile device records for the specified manufacturer.
	.EXAMPLE
		Get-SwSdMobileDevice -Model "Galaxy S21"

		Returns the mobile device records for the specified model.
	.EXAMPLE
		Get-SwSdMobileDevice -SerialNumber "1234567890"

		Returns the mobile device record for the specified serial number.
	.EXAMPLE
		Get-SwSdMobileDevice -Id "12345"

		Returns the mobile device record for the specified ID.
	.EXAMPLE
		Get-SwSdMobileDevice -ServiceProvider "Verizon"

		Returns the mobile device records for the specified service provider.
	.EXAMPLE
		Get-SwSdMobileDevice -IMEI "123456789012345"

		Returns the mobile device record for the specified IMEI.
	.EXAMPLE
		Get-SwSdMobileDevice -HREF "https://api.samanage.com/mobiles/1234567890"

		Returns the mobile device record for the specified HREF.
	.EXAMPLE
		Get-SwSdMobileDevice

		Returns all mobile device records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdMobileDevice.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Manufacturer,
		[parameter(Mandatory = $False)][string]$Model,
		[parameter(Mandatory = $False)][string]$SerialNumber,
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][string]$ServiceProvider,
		[parameter(Mandatory = $False)][string]$IMEI,
		[parameter(Mandatory = $False)][string]$HREF
	)
	try {
		$devices = getApiResponse -ApiName "Mobile Devices List"
		if ($devices) {

			if (![string]::IsNullOrWhiteSpace($Name)) {
				$devices | Where-Object { $_.name -eq $Name }
			} elseif (![string]::IsNullOrWhiteSpace($Manufacturer)) {
				$devices | Where-Object { $_.manufacturer -eq $Manufacturer }
			} elseif (![string]::IsNullOrWhiteSpace($Model)) {
				$devices | Where-Object { $_.model -eq $Model }
			} elseif (![string]::IsNullOrWhiteSpace($SerialNumber)) {
				$devices | Where-Object { $_.serial_number -eq $SerialNumber }
			} elseif (![string]::IsNullOrWhiteSpace($Id)) {
				$devices | Where-Object { $_.id -eq $Id }
			} elseif (![string]::IsNullOrWhiteSpace($ServiceProvider)) {
				$devices | Where-Object { $_.service_provider -eq $ServiceProvider }
			} elseif (![string]::IsNullOrWhiteSpace($IMEI)) {
				$devices | Where-Object { $_.imei -eq $IMEI }
			} else {
				return $devices
			}
		} else {
			throw "Failed to retrieve mobile devices. Status code: $($response.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}