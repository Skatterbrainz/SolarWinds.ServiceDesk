function New-SwSdIncident {
	<#
	.SYNOPSIS
		Creates a new incident in the Service Desk.
	.DESCRIPTION
		Creates a new incident in the Service Desk with the specified parameters.
	.PARAMETER Name
		Required. The name of the incident.
	.PARAMETER Description
		Required. The description of the incident.
	.PARAMETER Priority
		Optional. The priority of the incident. Default is "Medium".
	.PARAMETER Status
		Optional. The status of the incident.
	.PARAMETER Category
		Optional. The category of the incident.
	.PARAMETER SubCategory
		Optional. The subcategory of the incident.
	.PARAMETER Assignee
		Optional. The assignee of the incident. Example: "john.doe@contoso.com"
		Assignee email will be validated before creating the incident. If the assignee email is invalid, the incident will be created without an assignee.
	.PARAMETER GroupAssignee
		Optional. The group assignee of the incident. Example: "IT Support"
		Group name will be validated before creating the incident. If the group name is invalid, the incident will be created without a group assignee.
	.PARAMETER GroupAssigneeId
		Optional. The numeric ID of the group/queue assignee. Use this when queue names do not map to a Group name.
	.EXAMPLE
		New-SwSdIncident -Name "Test Incident" -Description "This is a test incident."
		Creates a new incident with the name "Test Incident" and the description "This is a test incident."
	.EXAMPLE
		New-SwSdIncident -Name "Test Incident" -Description "This is a test incident." -Priority "High" -Status "In Progress"
		Creates a new incident with the name "Test Incident", the description "This is a test incident.", priority "High", and status "In Progress".
	.EXAMPLE
		New-SwSdIncident -Name "Test Incident" -Description "This is a test incident." -Category "Software" -SubCategory "Application" -Assignee "John.Doe@contoso.com
		Creates a new incident with the name "Test Incident", the description "This is a test incident.", category "Software", and subcategory "Application".
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Incident
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdIncident.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('New-SDIncident', 'Add-SwSdIncident', 'Add-SDIncident')]
	param (
		[parameter(Mandatory = $True)][string]$Name,
		[parameter(Mandatory = $True)][string]$Description,
		[parameter(Mandatory = $False)][string]$Priority = "Medium",
		[parameter(Mandatory = $False)][string]$Status,
		[parameter(Mandatory = $False)][string]$Category,
		[parameter(Mandatory = $False)][string]$SubCategory,
		[parameter(Mandatory = $False)][string]$Assignee,
		[parameter(Mandatory = $False)][string]$GroupAssignee,
		[parameter(Mandatory = $False)][int][Alias('GroupId', 'QueueId')]$GroupAssigneeId
	)
	try {
		$url = getApiBaseURL -ApiName "Helpdesk Incidents List"
		Write-Verbose "url = $url"
		$body = @{
			name        = $Name
			description = $Description
			priority    = $Priority
		}
		if (![string]::IsNullOrEmpty($Status)) {
			$body.status = $Status
		}
		if (![string]::IsNullOrEmpty($Category)) {
			$body.category = $Category
		}
		if (![string]::IsNullOrEmpty($SubCategory)) {
			$body.subcategory = $SubCategory
		}
		if (![string]::IsNullOrEmpty($Assignee)) {
			if ($Assignee -match '^[\w\.\-]+@[\w\.\-]+\.\w+$') {
				Write-Verbose "Assignee email is valid: $Assignee"
				if (Get-SwSdUser -Email $Assignee) {
					Write-Verbose "Assignee email exists in Service Desk: $Assignee"
					$body.assignee = @{email = $Assignee}
				} else {
					Write-Warning "Assignee email does not exist in Service Desk: $Assignee. The incident will be created without an assignee."
					$Assignee = $null
				}
			} else {
				Write-Warning "Assignee email is invalid: $Assignee. The incident will be created without an assignee."
				$Assignee = $null
			}
		} else {
			if ($GroupAssigneeId) {
				Write-Verbose "Using queue/group assignee ID: $GroupAssigneeId"
				$body.assignee = @{id = $GroupAssigneeId}
				$body.group_assignee = @{id = $GroupAssigneeId}
			} elseif (![string]::IsNullOrEmpty($GroupAssignee)) {
				$group = Get-SwSdGroup -Name $GroupAssignee
				if ($group -and $group.id) {
					Write-Verbose "Group assignee exists in Service Desk: $GroupAssignee"
					$body.assignee = @{id = $group.id}
					$body.group_assignee = @{id = $group.id}
				} else {
					Write-Verbose "Group not found by name; attempting queue/group assignment by name: $GroupAssignee"
					$body.assignee = @{name = $GroupAssignee}
					$body.group_assignee = @{name = $GroupAssignee}
				}
			} else {
				Write-Verbose "No assignee or group assignee specified. The incident will be created without an assignee or group assignee."
				$GroupAssignee = $null
				$Assignee = $null
			}
		}
		$body = $body | ConvertTo-Json -Depth 10
		Write-Verbose "body = $body"
		$invokeWebRequestParams = @{
			Uri             = $url
			Headers         = $SDSession.headers
			Method          = 'Post'
			Body            = $body
			UseBasicParsing = $true
		}
		$response = (Invoke-SwSdWebRequest @invokeWebRequestParams | Select-Object -ExpandProperty Content | ConvertFrom-Json)
		$result = $response
	} catch {
		$result = [pscustomobject]@{
			Status      = 'Error'
			Message     = $_.Exception.Message
			Trace       = $_.ScriptStackTrace
			Name        = $Name
			Description = $Description
		}
	} finally {
		$result
	}
}