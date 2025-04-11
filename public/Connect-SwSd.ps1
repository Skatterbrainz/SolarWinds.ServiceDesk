function Connect-SwSD {
	<#
	.SYNOPSIS
		Creates a new SolarWinds Service Desk session.
	.DESCRIPTION
		Creates a new SolarWinds Service Desk session. If a session already exists, it will return the existing session unless the `-Refresh` switch is used.
		You can provide the API token, URL, version, and format as parameters. If the API token is not provided, it will look for the `$env:SWSDToken` environment variable.
		You can also set the API URL, version, and format as parameters. The default values are:
			- ApiUrl: "https://api.samanage.com"
			- ApiVersion: "v2.1"
			- ApiFormat: "json"
	.PARAMETER ApiToken
		The authentication API token. This is required if not set in the environment variable `$env:SWSDToken`.
	.PARAMETER ApiUrl
		The API URL. Default is "https://api.samanage.com".
	.PARAMETER ApiVersion
		The API version. Default is "v2.1".
	.PARAMETER ApiFormat
		The API format: json or xml. Default is "json".
	.PARAMETER Refresh
		Refresh the session.
	.EXAMPLE
		Connect-SwSD -ApiToken "your_api_token"
		Creates a new SolarWinds Service Desk session with the specified API token.
	.EXAMPLE
		Connect-SwSD -ApiUrl "https://api.samanage.com" -ApiVersion "v2.1" -ApiFormat "json"
		Creates a new SolarWinds Service Desk session with the specified API URL, version, and format.
	.EXAMPLE
		Connect-SwSD -Refresh
		Refreshes the existing SolarWinds Service Desk session.
	.NOTES
		Reference: https://apidoc.samanage.com/#section/General-Concepts/Service-URL
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Connect-SwSD.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $False)][string]$ApiToken,
		[parameter(Mandatory = $False)][string]$ApiUrl = "https://api.samanage.com",
		[parameter(Mandatory = $False)][string]$ApiVersion = "v2.1",
		[parameter(Mandatory = $False)][string][ValidateSet('json','xml')]$ApiFormat = "json",
		[parameter(Mandatory = $False)][switch]$Refresh
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
