function Get-SwSdComment {
	<#
	.SYNOPSIS
		Returns the comments for the specified incident.
	.DESCRIPTION
		Returns the comments for the specified incident.
	.PARAMETER IncidentNumber
		The incident number.
	.EXAMPLE
		Get-SwSdComment -IncidentNumber 12345

		Returns the comments for the specified incident number.
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdComment.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string]$IncidentNumber
	)
	try {
		$incident = Get-SwSdIncident -Number $IncidentNumber -NoRequestData
		if ($incident) {
			$baseurl = getApiBaseURL -ApiName "Helpdesk Incidents List" -NoExtension
			$url = "$($baseurl)/$($incident.id)/comments.json"
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
