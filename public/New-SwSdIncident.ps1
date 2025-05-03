function New-SwSdIncident {
	<#
	.SYNOPSIS
		Creates a new incident in the Service Desk.
	.DESCRIPTION
		Creates a new incident in the Service Desk with the specified parameters.
	.PARAMETER Name
		The name of the incident.
	.PARAMETER Description
		The description of the incident.
	.PARAMETER Priority
		The priority of the incident. Default is "Normal".
	.PARAMETER Status
		The status of the incident. Default is "Pending Assignment".
	.PARAMETER Category
		The category of the incident. Default is "General".
	.PARAMETER SubCategory
		The subcategory of the incident. Default is "General".
	.EXAMPLE
		New-SwSdIncident -Name "Test Incident" -Description "This is a test incident."
		Creates a new incident with the name "Test Incident" and the description "This is a test incident."
	.EXAMPLE
		New-SwSdIncident -Name "Test Incident" -Description "This is a test incident." -Priority "High" -Status "In Progress"
		Creates a new incident with the name "Test Incident", the description "This is a test incident.", priority "High", and status "In Progress".
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Incident
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdIncident.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string]$Name,
		[parameter(Mandatory = $True)][string]$Description,
		[parameter(Mandatory = $False)][string]$Priority = "Normal",
		[parameter(Mandatory = $False)][string]$Status = "Pending Assignment",
		[parameter(Mandatory = $False)][string]$Category = "General",
		[parameter(Mandatory = $False)][string]$SubCategory = "General"
	)
	try {
		$url = getApiBaseURL -ApiName "Helpdesk Incidents List"
		Write-Verbose "url = $url"
		$body = @{
			name        = $Name
			description = $Description
			priority    = $Priority
			status      = $Status
			category    = $Category
			subcategory = $SubCategory
		} | ConvertTo-Json -Depth 10
		Write-Verbose "body = $body"
		$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Post -Body $body
	} catch {
		$result = [pscustomobject]@{
			Status    = 'Error'
			Message   = $_.Exception.Message
			Trace     = $_.ScriptStackTrace
			Name      = $Name
			Description= $Description
		}
	} finally {
		$result
	}
}