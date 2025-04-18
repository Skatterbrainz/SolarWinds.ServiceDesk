function Get-SwSdIncidentLink {
	<#
	.SYNOPSIS
		Generates a unique URL for the specified incident ID and name.
	.DESCRIPTION
		Generates a unique URL for the specified incident ID and name.
	.PARAMETER Number
		The incident number.
	.PARAMETER Name
		The incident name.
	.EXAMPLE
		Get-SwSdIncidentLink -Number 149737766 -Name "NH 2/18/25 Abenaa Ampem MBL WKR PKG #1 3000000"
		Returns: 149737766-nh-2-18-25-abenaa-ampem-mbl-wkr-pkg-1-3000000.json
	.NOTES
		This is also the tail end of the [href] property of an incident.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdIncidentLink.md
	#>
	param (
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$Name
	)
	Write-Output "$($Number)-$(($Name.Trim() -replace ' ','-' -replace '#','' -replace '/','-').ToLower()).json"
}
