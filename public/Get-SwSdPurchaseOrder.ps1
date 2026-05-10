function Get-SwSdPurchaseOrder {
	<#
	.SYNOPSIS
		Returns the Service Desk purchase order records for the specified criteria or all purchase orders.
	.DESCRIPTION
		Returns the Service Desk purchase order records for the specified criteria or all purchase orders.
	.PARAMETER Name
		The purchase order name. If provided, returns the specific purchase order record.
	.PARAMETER Id
		The purchase order ID. If provided, returns the specific purchase order record.
	.PARAMETER Status
		The purchase order status. If provided, returns the specific purchase order record.
	.PARAMETER HREF
		The purchase order HREF. If provided, returns the specific purchase order record.
	.EXAMPLE
		Get-SwSdPurchaseOrder -Name "Purchase Order 1"
		
		Returns the purchase order record for the specified name.
	.EXAMPLE
		Get-SwSdPurchaseOrder -Id "12345"

		Returns the purchase order record for the specified ID.
	.EXAMPLE
		Get-SwSdPurchaseOrder -Status "Open"
		
		Returns the purchase order records for the specified status.
	.EXAMPLE
		Get-SwSdPurchaseOrder -HREF "https://api.samanage.com/purchase_orders/1234567890"

		Returns the purchase order record for the specified HREF.
	.EXAMPLE
		Get-SwSdPurchaseOrder

		Returns all purchase order records.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPurchaseOrder.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdPurchaseOrders', 'Get-SwSdPurchaseOrderList', 'Get-SDPurchaseOrder')]
	param (
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][int]$Id,
		[parameter(Mandatory = $False)][string]$Status,
		[parameter(Mandatory = $False)][string]$HREF
	)
	try {
		if ($HREF) {
			Write-Verbose "Search by HREF: $HREF"
			$Session = Connect-SwSD
			$url = "https://api.samanage.com/$HREF"
			getApiResponseByURL -Url $url	
		} elseif ($Id) {
			Write-Verbose "Search by Id: $Id"
			Write-Output (getApiListOrItem -ApiName "Purchase Orders List" -Id $Id)
		} elseif (![string]::IsNullOrWhiteSpace($Name)) {
			$purchaseOrders = getApiListOrItem -ApiName "Purchase Orders List" -PerPage 100 -QueryParameters @{ name = $Name }
			$purchaseOrders | Where-Object { $_.name -eq $Name }
		} elseif (![string]::IsNullOrWhiteSpace($Status)) {
			$purchaseOrders = getApiListOrItem -ApiName "Purchase Orders List" -PerPage 100 -QueryParameters @{ state = $Status }
			$purchaseOrders | Where-Object { $_.state -eq $Status }
		} else {
			getApiListOrItem -ApiName "Purchase Orders List" -PerPage 100 -AllPages
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}