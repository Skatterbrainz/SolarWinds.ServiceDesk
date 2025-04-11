function Export-SwSdIncidentDetails {
	<#
	.SYNOPSIS
		Exports the incident details information to a file.
	.DESCRIPTION
		Exports the incident details (description property) information to a file.
	.PARAMETER Number
		The incident number.
	.PARAMETER SaveToFile
		Save the request data to a file.
	.PARAMETER OutputPath
		The path to save the file. Default is the user's Documents folder.
	.PARAMETER Show
		Display the exported HTML request data in the default web browser.
	.EXAMPLE
		Export-SwSdIncidentDetails -Number 12345 -SaveToFile
		Exports the incident details for incident number 12345 to a file.
	.EXAMPLE
		Export-SwSdIncidentDetails -Number 12345 -SaveToFile -OutputPath "C:\Temp"
		Exports the incident details for incident number 12345 to a file in the specified path.
	.EXAMPLE
		Export-SwSdIncidentDetails -Number 12345 -Show
		Exports the incident details for incident number 12345 and displays it in the default web browser.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Incident
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Export-SwSdIncidentDetails.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter()][switch]$SaveToFile,
		[parameter()][string]$OutputPath,
		[parameter()][switch]$Show
	)
	$incident = Get-SwSDIncident -Number $Number -IncludeDescription -NoRequestData
	if ($incident) {
		if ($SaveToFile.IsPresent -and [string]::IsNullOrEmpty($OutputPath)) {
			$OutputPath = (Resolve-Path (Join-Path "~" "Documents")).Path
			$filepath = Join-Path $OutputPath "incident-$($Number)_description.html"
			$incident.description.Trim() | Out-File -FilePath $filepath -Encoding utf8 -Force
			Write-Host "Incident $Number request data exported to: $filepath"
			if ($Show.IsPresent) {
				Invoke-Item $filepath
			}
		} else {
			$incident.description.Trim()
		}
	} else {
		Write-Warning "Incident $Number not found."
	}
}
