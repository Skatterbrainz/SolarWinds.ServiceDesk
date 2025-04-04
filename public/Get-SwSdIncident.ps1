function Get-SwSDIncident {
	<#
	.DESCRIPTION
		Returns a Service Desk incident for the specified incident Number or ID + name.
	.PARAMETER Number
		The incident number.
	.PARAMETER Id
		The incident ID.
	.PARAMETER Name
		The incident name. Required if Id is provided.
	.EXAMPLE
		Get-SwSDIncident -Number 12345
		Returns the incident record for incident number 12345.
	.EXAMPLE
		Get-SwSDIncident -Id 123456789 -Name "Incident Name"
		Returns the incident record for incident ID 12345 with the specified name.
	#>
	[CmdletBinding()]
	param (
		[parameter(ParameterSetName='Number')][string]$Number,
		[parameter(ParameterSetName='ID')][int32]$Id,
		[parameter(ParameterSetName='ID')][string]$Name
	)
	try {
		$Session  = Connect-SwSD
		if (![string]::IsNullOrEmpty($Number)) {
			$baseurl = Get-SwSDAPI -Name "Search"
			$url = "$($baseurl)?q=number:$Number"
		} elseif (![string]::IsNullOrEmpty($Id) -and ![string]::IsNullOrEmpty($Name)) {
			$baseurl = Get-SwSDAPI -Name "Helpdesk Incidents List"
			$idx = Get-SwSDIncidentLink -Number $Id -Name $Name
			$url = "$($baseurl.Replace('.json',''))/$idx"
		} else {
			throw "Either the Number or ID + Name must be provided."
		}
		Write-Verbose "url = $url"
		$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
	} catch {
		$result = [pscustomobject]@{
			Status    = 'Error'
			Activity  = $($_.CategoryInfo.Activity -join (";"))
			Message   = $($_.Exception.Message -join (";"))
			Trace     = $($_.ScriptStackTrace -join (";"))
			Incident  = $IncidentNumber
		}
	} finally {
		$result
	}
}