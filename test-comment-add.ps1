function Add-SDComment {
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$IncidentNumber,
		[parameter(Mandatory)][string]$Comment,
		[parameter(Mandatory)][string]$Assignee,
		[parameter()][switch]$Private
	)
	try {
		$Session = New-SDSession
		$incident = Get-SDIncident -Number $IncidentNumber -NoRequestData
		if ($incident) {
			$baseurl = Get-SDAPI -Name "Helpdesk Incidents List"
			$url = "$($baseurl.replace('.json',''))/$($incident.id)/comments"
			$body = @{
				"comment" = @{
					"body"       = $Comment.Trim()
					"is_private" = $($Private.IsPresent)
					"user" = @{"email" = $Assignee}
				}
			} | ConvertTo-Json
			$response = Invoke-RestMethod -Method POST -Uri $url -ContentType "application/json" -Headers $Session.headers -Body $body
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

$token = Get-Content ~/sdtoken.txt
New-SDSession -ApiToken $token

$svcAccount = "svc_ULMAPI@AdvocatesInc.org"

Add-SDComment -IncidentNumber 54833 -Comment "Test comment 5" -Assignee $svcAccount -Private -Verbose