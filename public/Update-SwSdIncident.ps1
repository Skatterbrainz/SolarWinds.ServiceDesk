function Update-SwSdIncident {
	<#
	.SYNOPSIS
		Updates the specified incident record with the provided assignee and/or status.
	.DESCRIPTION
		Updates the specified incident record with the provided assignee and/or status.
		You can specify either the assignee or status, or both.
		Assignee must be a valid SWSD user account.
	.PARAMETER Number
		The incident number.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER GroupAssignee
		The name of the group assignee. This parameter is used to assign the incident to a group instead of an individual user. The group name must be a valid SWSD group.
	.PARAMETER GroupAssigneeId
		The numeric ID of the group/queue assignee. Use this when queue names do not map to a Group name.
	.PARAMETER Status
		The status of the incident: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled.
		The default status is 'Assigned'.
	.PARAMETER Description
		The description of the incident update. This parameter is used to add a comment to the incident when updating the assignee or status. The description will be added as a comment to the incident.
	.PARAMETER Category
		The category of the incident. This parameter is used to update the incident category. The category must be a valid SWSD category.
	.EXAMPLE
		Update-SwSdIncident -Number 12345 -Assignee "jsmith@contoso.org" -Status "Pending Assignment"
		
		Updates the incident 12345 with the specified assignee 'jsmith@contoso.org' and status 'Pending Assignment'.
	.EXAMPLE
		Update-SwSdIncident -Number 12345 -Status "Closed"

		Updates the incident 12345 with the specified status 'Closed'
	.NOTES
		The Assignee must be a valid SWSD user account.
		Reference: https://apidoc.samanage.com/#tag/Incident/operation/updateIncidentById
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdIncident.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	param (
		[parameter(Mandatory = $True)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter(Mandatory = $False)][string][Alias('Email')]$Assignee,
		[parameter(Mandatory = $False)][string][Alias('Group')]$GroupAssignee,
		[parameter(Mandatory = $False)][int][Alias('GroupId', 'QueueId')]$GroupAssigneeId,
		[parameter(Mandatory = $False)][string][Alias('State')]$Status,
		[parameter(Mandatory = $False)][string]$Category,
		[parameter(Mandatory = $False)][string]$SubCategory,
		[parameter(Mandatory = $False)][string]$Description
	)
	try {
		$SDSession = Connect-SwSD

		function New-QueueAssigneePayload {
			param(
				[parameter(Mandatory = $False)][int]$QueueId,
				[parameter(Mandatory = $False)][string]$QueueName
			)
			if ($QueueId) {
				return @{
					id   = $QueueId
					type = 'AssignableQueueGroup'
				}
			}
			return @{
				name = $QueueName
				type = 'AssignableQueueGroup'
			}
		}

		if ([string]::IsNullOrEmpty($Assignee) -and [string]::IsNullOrEmpty($GroupAssignee) -and !$GroupAssigneeId -and [string]::IsNullOrEmpty($Status) -and [string]::IsNullOrEmpty($Category) -and [string]::IsNullOrEmpty($SubCategory) -and [string]::IsNullOrEmpty($Description)) {
			throw "Assignee, GroupAssignee, GroupAssigneeId, Status, Category, SubCategory, or Description must be provided."
		}
		Write-Verbose "Requesting Incident $Number"
		$incident = Get-SwSdIncident -Number $Number
		if (!$incident) {
			throw "Incident $Number not found."
		}
		$msg = ""
		$body = @{
			incident = @{
				name = $incident.name
				description = $incident.description
				category = @{
					name = $incident.category.name
				}
				priority = $incident.priority
				requester = @{
					email = $incident.requester.email
				}
			}
		}

		if (![string]::IsNullOrEmpty($Status)) {
			$msg += "Status: $($Status.Trim())"
			$body.incident.state = "$($Status.Trim())"
		}
		if (![string]::IsNullOrEmpty($Assignee)) {
			Write-Verbose "Verifying User $Assignee"
			$user = Get-SwSdUser -Email $Assignee
			if (!$user) {
				throw "User $Assignee not found."
			}
			$msg += "Assignee: $($Assignee.Trim())"
			$body.incident.assignee = @{
				email = "$($Assignee.Trim())"
			}
		} elseif ($GroupAssigneeId) {
			$msg += "Group Assignee Id: $GroupAssigneeId"
			$queuePayload = New-QueueAssigneePayload -QueueId $GroupAssigneeId
			$body.incident.assignee = $queuePayload
			$body.incident.group_assignee = $queuePayload
		} elseif (![string]::IsNullOrEmpty($GroupAssignee)) {
			$targetGroupName = $GroupAssignee.Trim()
			$queue = $null
			$group = $null
			Write-Verbose "Verifying Queue/Group $targetGroupName"
			try {
				$queue = Get-SwSdQueue -Name $targetGroupName | Select-Object -First 1
			} catch {
			}
			if (!$queue -or !$queue.id) {
				$group = Get-SwSdGroup -Name $targetGroupName | Select-Object -First 1
			}
			if ($queue -and $queue.id) {
				$msg += "Queue Assignee Id: $($queue.id)"
				$queuePayload = New-QueueAssigneePayload -QueueId ([int]$queue.id)
				$body.incident.assignee = $queuePayload
				$body.incident.group_assignee = $queuePayload
			} elseif ($group -and $group.id) {
				$msg += "Group Assignee Id: $($group.id)"
				$queuePayload = New-QueueAssigneePayload -QueueId ([int]$group.id)
				$body.incident.assignee = $queuePayload
				$body.incident.group_assignee = $queuePayload
			} else {
				$msg += "Group Assignee: $targetGroupName"
				$queuePayload = New-QueueAssigneePayload -QueueName $targetGroupName
				$body.incident.assignee = $queuePayload
				$body.incident.group_assignee = $queuePayload
			}
		}
		if (![string]::IsNullOrEmpty($Category)) {
			Write-Verbose "Verifying Category $Category"
			$category = Get-SwSdCatalogCategory -Name $Category
			if (!$category) {
				throw "Category $Category not found."
			}
			$msg += "Category: $($Category.Trim())"
			$body.incident.category = @{
				name = "$($Category.Trim())"
			}
		}
		if (![string]::IsNullOrEmpty($SubCategory)) {
			Write-Verbose "Verifying SubCategory $SubCategory"
			$subcategory = Get-SwSdCatalogSubCategory -Name $SubCategory
			if (!$subcategory) {
				throw "SubCategory $SubCategory not found."
			}
			$msg += "SubCategory: $($SubCategory.Trim())"
			$body.incident.subcategory = @{
				name = "$($SubCategory.Trim())"
			}
		}
		$json = $body | ConvertTo-Json -Depth 10
		$url = $incident.href
		Write-Verbose "Updating incident at URL: $($url)"
		$params = @{
			Method          = "PUT"
			Uri             = $url
			ContentType     = "application/json"
			Headers         = $SDSession.headers
			Body            = $json
			UseBasicParsing = $true
		}
		Write-Verbose "Request body: $($body | ConvertTo-Json -Depth 10)"
		$response = Invoke-WebRequest @params
		Write-Verbose "Incident $Number updated: $($response.state)"
		$result = [pscustomobject]@{
			Status        = "Success"
			State         = $Status
			Assignee      = $Assignee
			GroupAssignee = $GroupAssignee
			Category      = $Category
			SubCategory   = $SubCategory
			Description   = $Description
		}
		Write-Verbose "Update details: $($msg -join ("; "))"
	} catch {
		$result = [pscustomobject]@{
			Status   = "Error"
			Activity = $($_.CategoryInfo.Activity -join (";"))
			Message  = $($_.Exception.Message -join (";"))
			Trace    = $($_.ScriptStackTrace -join (";"))
		}
	} finally {
		$result
	}
}
