function Remove-SDComment {
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$IncidentNumber,
		[parameter(Mandatory)][string]$CommentId
	)
	try {
		$Session  = New-SDSession
		$incident = Get-SDIncident -Number $IncidentNumber -NoRequestData
		if ($incident) {
			$baseurl = Get-SDAPI -Name "Helpdesk Incidents List"
			$url     = "$($baseurl -replace '.json','')/$($incident.id)/comments/$($CommentId.Trim())"
			Write-Verbose "url: $url"
			$params = @{
				Uri         = $url
				Method      = 'DELETE'
				ContentType = "application/json"
				Headers     = $Session.headers
				ErrorAction = 'Stop'
			}
			$response = Invoke-RestMethod @params
			$result   = $response
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
			CommentId = $CommentId
		}
	} finally {
		$result
	}
}


#$comments = Get-SDComments -IncidentNumber 54833
$comment = Get-SDComments -IncidentNumber 54833 | Where-Object {$_.body -eq 'This is a test comment (CAP automation)'}

if ($comment) {
	Remove-SDComment -IncidentNumber 54833 -CommentId $comment.id -Verbose
} else {
	Write-Host "Comment not found."
}