function Get-SwSdOtherAsset {
	<#
	.SYNOPSIS
		Returns the Service Desk other asset records for the specified criteria or all assets.
	.DESCRIPTION
		Returns the Service Desk other asset records for the specified criteria or all assets.
	.PARAMETER Name
		The other asset name. If provided, returns the specific asset record.
	.PARAMETER Manufacturer
		The other asset manufacturer. If provided, returns the specific asset record.
	.PARAMETER Model
		The other asset model. If provided, returns the specific asset record.
	.PARAMETER SerialNumber
		The other asset serial number. If provided, returns the specific asset record.
	.PARAMETER Id
		The other asset ID. If provided, returns the specific asset record.
	.PARAMETER AssetId
		The other asset ID. If provided, returns the specific asset record.
	.PARAMETER HREF
		The other asset HREF. If provided, returns the specific asset record.
	.EXAMPLE
		Get-SwSdOtherAsset -Name "Other Asset 1"

		Returns the other asset record for the specified name.
	.EXAMPLE
		Get-SwSdOtherAsset -Manufacturer "Manufacturer A"

		Returns the other asset records for the specified manufacturer.	
	.EXAMPLE
		Get-SwSdOtherAsset -Model "Model B"

		Returns the other asset records for the specified model.
	.EXAMPLE
		Get-SwSdOtherAsset -SerialNumber "1234567890"

		Returns the other asset record for the specified serial number.
	.EXAMPLE
		Get-SwSdOtherAsset -Id "12345"

		Returns the other asset record for the specified ID.
	.EXAMPLE
		Get-SwSdOtherAsset -AssetId "54321"

		Returns the other asset record for the specified asset ID.
	.EXAMPLE
		Get-SwSdOtherAsset -HREF "https://api.samanage.com/other_assets/1234567890"

		Returns the other asset record for the specified HREF.
	.EXAMPLE
		Get-SwSdOtherAsset
		
		Returns all other asset records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdOtherAsset.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][string]$Manufacturer,
		[parameter(Mandatory = $False)][string]$Model,
		[parameter(Mandatory = $False)][string]$SerialNumber,
		[parameter(Mandatory = $False)][string]$Id,
		[parameter(Mandatory = $False)][string]$AssetId,
		[parameter(Mandatory = $False)][string]$HREF
	)
	try {
		$assets = getApiResponse -ApiName "Other Assets List"
		if ($assets) {
			if (![string]::IsNullOrWhiteSpace($Name)) {
				$assets | Where-Object { $_.name -eq $Name }
			} elseif (![string]::IsNullOrWhiteSpace($Manufacturer)) {
				$assets | Where-Object { $_.manufacturer -eq $Manufacturer }
			} elseif (![string]::IsNullOrWhiteSpace($Model)) {
				$assets | Where-Object { $_.model -eq $Model }
			} elseif (![string]::IsNullOrWhiteSpace($SerialNumber)) {
				$assets | Where-Object { $_.serial_number -eq $SerialNumber }
			} elseif (![string]::IsNullOrWhiteSpace($Id)) {
				$assets | Where-Object { $_.id -eq $Id }
			} elseif (![string]::IsNullOrWhiteSpace($AssetId)) {
				$assets | Where-Object { $_.asset_id -eq $AssetId }
			} elseif (![string]::IsNullOrWhiteSpace($HREF)) {
				$assets | Where-Object { $_.href -eq $HREF }
			} else {
				return $assets
			}
		} else {
			throw "Failed to retrieve other assets. Status code: $($response.StatusCode)"
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}