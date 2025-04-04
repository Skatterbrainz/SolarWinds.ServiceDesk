function Get-SwSDComment {
	<#
	.SYNOPSIS
		Returns the comments for the specified incident.
	.DESCRIPTION
		Returns the comments for the specified incident.
	.PARAMETER IncidentNumber
		The incident number.
	.EXAMPLE
		Get-SwSDComment -IncidentNumber 12345
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$IncidentNumber
	)
	try {
		$Session     = Connect-SwSD
		$incident    = Get-SwSDIncident -Number $IncidentNumber -NoRequestData
		if ($incident) {
			$baseurl  = (Get-SwSDAPI -Name "Helpdesk Incidents List") -replace ".json", ""
			$url      = "$($baseurl)/$($incident.id)/comments.json"
			Write-Verbose "Url: $url"
			$params = @{
				Uri         = $url
				Method      = 'GET'
				ContentType = "application/json"
				Headers     = $Session.headers
				ErrorAction = 'Stop'
			}
			$response    = Invoke-RestMethod @params
			$result      = $response
		} else {
			throw "Incident not found: $IncidentNumber"
		}
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
