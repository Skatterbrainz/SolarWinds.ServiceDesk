function Add-SwSDComment {
	<#
	.SYNOPSIS
		Adds a comment to the specified incident.
	.DESCRIPTION
		Adds a comment to the specified incident.
	.PARAMETER IncidentNumber
		The incident number.
	.PARAMETER Comment
		The comment to add.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Private
		Make the comment private.
	.EXAMPLE
		Add-SwSDComment -IncidentNumber 12345 -Comment "This is a test comment." -Assignee "svc_ULMAPI@contoso.com"
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$IncidentNumber,
		[parameter(Mandatory)][string]$Comment,
		[parameter(Mandatory)][string]$Assignee,
		[parameter()][switch]$Private
	)
	try {
		$Session  = Connect-SwSD
		$incident = Get-SwSDIncident -Number $IncidentNumber -NoRequestData
		if ($incident) {
			$baseurl = Get-SwSDAPI -Name "Helpdesk Incidents List"
			$url = "$($baseurl.replace('.json',''))/$($incident.id)/comments"
			Write-Verbose "Url: $url"
			$body = @{
				"comment" = @{
					"body"       = $Comment.Trim()
					"is_private" = $($Private.IsPresent)
					"user" = @{"email" = $Assignee}
				}
			} | ConvertTo-Json
			$params = @{
				Uri         = $url
				Method      = 'POST'
				ContentType = "application/json"
				Headers     = $Session.headers
				Body        = $body
				ErrorAction = 'Stop'
			}
			$response = Invoke-RestMethod @params
			$result = $response
		} else {
			Write-Warning "Incident $IncidentNumber not found."
		}
	} catch {
		$msg = $_.Exception.Message
		if ($msg -notmatch '406') {
			$result = [pscustomobject]@{
				Status    = 'Error'
				Activity  = $($_.CategoryInfo.Activity -join (";"))
				Message   = $($_.Exception.Message -join (";"))
				Trace     = $($_.ScriptStackTrace -join (";"))
				Incident  = $IncidentNumber
			}
		} else {
			$result = $True
		}
	} finally {
		$result
	}
}
