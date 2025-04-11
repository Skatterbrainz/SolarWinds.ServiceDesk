function Add-SwSdComment {
	<#
	.SYNOPSIS
		Adds a comment to the specified incident.
	.DESCRIPTION
		Adds a comment to the specified incident. The comment can be made private and assigned to a user.
	.PARAMETER IncidentNumber
		The incident number.
	.PARAMETER Comment
		The comment to add.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Private
		Make the comment private.
	.EXAMPLE
		Add-SwSdComment -IncidentNumber 12345 -Comment "This is a comment." -Assignee "jsmith@contoso.com"
		Adds a comment to the specified incident number with the provided comment and assignee.
	.EXAMPLE
		Add-SwSdComment -IncidentNumber 12345 -Comment "This is a new comment" -Assignee "jsmith@contoso.com" -Private
		Adds a private comment to the specified incident number with the provided comment and assignee.
	.NOTES
		The Assignee must be a valid SWSD user account.
		Reference: https://apidoc.samanage.com/#tag/Incident
		Reference: https://apidoc.samanage.com/#tag/Comment
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Add-SwSdComment.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $True)][string]$IncidentNumber,
		[parameter(Mandatory = $True)][string]$Comment,
		[parameter(Mandatory = $True)][string]$Assignee,
		[parameter(Mandatory = $False)][switch]$Private
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
