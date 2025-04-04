function Connect-SwSD {
	<#
	.DESCRIPTION
		Creates a new SolarWinds Service Desk session.
	.PARAMETER ApiToken
		The authentication API token.
	.PARAMETER ApiUrl
		The API URL. Default is "https://api.samanage.com".
	.PARAMETER ApiVersion
		The API version. Default is "v2.1".
	.PARAMETER ApiFormat
		The API format: json or xml. Default is "json".
	.PARAMETER Refresh
		Refresh the session.
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$ApiToken,
		[parameter()][string]$ApiUrl = "https://api.samanage.com",
		[parameter()][string]$ApiVersion = "v2.1",
		[parameter()][string][ValidateSet('json','xml')]$ApiFormat = "json",
		[parameter()][switch]$Refresh
	)
	try {
		if ($SDSession -and !$Refresh.IsPresent) {
			$SDSession
		} else {			
			if (![string]::IsNullOrWhiteSpace($ApiToken)) {
				$global:SwSdToken = $ApiToken
			} else {
				if ($env:SWSDToken) {
					$global:SwSdToken = $env:SWSDToken
				} else {
					throw "API Token not provided or defined in the environment.(`$env:SWSDToken)"
				}
			}
			$headers = @{
				"X-Samanage-Authorization" = "Bearer $($global:SwSdToken)"
				"Accept" = "application/vnd.samanage.$($ApiVersion)+$($ApiFormat)"
				"Content-Type" = "application/json"
			}
			$global:SDSession = @{
				headers = $headers
				apiurl  = $ApiUrl
				timeSet = (Get-Date)
			}
			$SDSession
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}
