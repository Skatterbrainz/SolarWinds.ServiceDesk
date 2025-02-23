function Update-SDComment {
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$IncidentNumber,
		[parameter(Mandatory)][string]$CommentId,
		[parameter(Mandatory)][string]$Comment,
		[parameter()][string]$Assignee,
		[parameter()][switch]$Private
	)
	try {
		$Session = New-SDSession
		$incident = Get-SDIncident -Number $IncidentNumber -NoRequestData
		if ($incident) {
			$baseurl = Get-SDAPI -Name "Helpdesk Incidents List"
			$url  = "$($baseurl.replace('.json',''))/$($incident.id)/comments/$($CommentId)"
			$body = @{
				"comment" = @{
					"body" = "<p>This is a modified comment</p>"
					"is_private" = "false"
				}
			}
			if (![string]::IsNullOrWhiteSpace($Assignee)) {
				$body.comment.user = @{ "email" = "$Assignee" }
			}
			$json = $body | ConvertTo-Json
			Write-Verbose "url: $url"
			Write-Verbose "body: $json"
			$params = @{
				Uri         = $url
				Method      = 'PUT'
				ContentType = "application/json"
				Headers     = $Session.headers
				Body        = $json
				ErrorAction = 'Stop'
			}
			$response = Invoke-RestMethod @params
			$result = $response
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

$token = Get-Content ~/sdtoken.txt
New-SDSession -ApiToken $token

$comments = Get-SDComments -IncidentNumber 54833
$comment = $comments | Where-Object {$_.body -eq 'This is a test comment posted from CAP automation'}

if ($comment) {
	Update-SDComment -IncidentNumber 54833 -CommentId $comment.id -Comment "Modified comment" -Verbose
} else {
	Write-Host "Comment not found."
}