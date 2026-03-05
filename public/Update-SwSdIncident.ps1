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

		function Invoke-IncidentUpdateRequest {
			param(
				[parameter(Mandatory = $True)][string]$Uri,
				[parameter(Mandatory = $True)][hashtable]$Headers,
				[parameter(Mandatory = $True)][hashtable]$IncidentBody
			)
			$payload = @{ incident = $IncidentBody } | ConvertTo-Json -Depth 10
			$params = @{
				Method          = "PUT"
				Uri             = $Uri
				ContentType     = "application/json"
				Headers         = $Headers
				Body            = $payload
				UseBasicParsing = $true
			}
			Write-Verbose "Request body: $(@{ incident = $IncidentBody } | ConvertTo-Json -Depth 10)"
			try {
				$response = Invoke-WebRequest @params
				return [pscustomobject]@{
					Success    = $true
					StatusCode = [int]$response.StatusCode
					ErrorBody  = $null
				}
			} catch {
				$statusCode = $null
				$errorBody = $null
				if ($_.Exception.Response) {
					try {
						$statusCode = [int]$_.Exception.Response.StatusCode
					} catch {
					}
				}
				if ($_.ErrorDetails -and $_.ErrorDetails.Message) {
					$errorBody = $_.ErrorDetails.Message
				}
				return [pscustomobject]@{
					Success    = $false
					StatusCode = $statusCode
					ErrorBody  = $errorBody
				}
			}
		}

		function Get-IncidentByHref {
			param(
				[parameter(Mandatory = $True)][string]$Uri,
				[parameter(Mandatory = $True)][hashtable]$Headers
			)
			$requestUri = $Uri
			if ($requestUri -notmatch '\?') {
				$requestUri = "$requestUri?layout=long"
			} elseif ($requestUri -notmatch '(^|&)layout=') {
				$requestUri = "$requestUri&layout=long"
			}
			$params = @{
				Method          = "GET"
				Uri             = $requestUri
				Headers         = $Headers
				ContentType     = "application/json"
				UseBasicParsing = $true
			}
			$response = Invoke-WebRequest @params
			$data = $response.Content | ConvertFrom-Json
			if ($data -and $data.incident) { return $data.incident }
			return $data
		}

		function Test-QueueAssignmentMatch {
			param(
				[parameter(Mandatory = $True)]$IncidentObject,
				[parameter(Mandatory = $False)][int]$QueueId,
				[parameter(Mandatory = $False)][string]$QueueName
			)
			$groupId = if ($IncidentObject.group_assignee -and $IncidentObject.group_assignee.id) { [string]$IncidentObject.group_assignee.id } else { $null }
			$groupName = if ($IncidentObject.group_assignee -and $IncidentObject.group_assignee.name) { [string]$IncidentObject.group_assignee.name } else { $null }
			$assigneeIsUser = $null
			if ($IncidentObject.assignee -and $null -ne $IncidentObject.assignee.is_user) {
				$assigneeIsUser = [string]$IncidentObject.assignee.is_user
			}
			$assigneeId = if ($IncidentObject.assignee -and $IncidentObject.assignee.id) { [string]$IncidentObject.assignee.id } else { $null }
			$assigneeName = if ($IncidentObject.assignee -and $IncidentObject.assignee.name) { [string]$IncidentObject.assignee.name } else { $null }

			$matched = $false
			if ($QueueId) {
				$matched = ($groupId -eq [string]$QueueId) -or (($assigneeIsUser -eq 'False' -or $assigneeIsUser -eq 'false') -and ($assigneeId -eq [string]$QueueId))
			} elseif (![string]::IsNullOrWhiteSpace($QueueName)) {
				$matched = ($groupName -ieq [string]$QueueName) -or (($assigneeIsUser -eq 'False' -or $assigneeIsUser -eq 'false') -and ($assigneeName -ieq [string]$QueueName))
			}

			return [pscustomobject]@{
				Matched      = $matched
				GroupId      = $groupId
				GroupName    = $groupName
				AssigneeId   = $assigneeId
				AssigneeName = $assigneeName
				AssigneeUser = $assigneeIsUser
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
		$body = @{ incident = @{} }

		if (![string]::IsNullOrEmpty($Status)) {
			$msg += "Status: $($Status.Trim())"
			$body.incident.state = "$($Status.Trim())"
		}
		$targetQueueId = $null
		$targetQueueName = $null
		$primaryRejectedQueueIdPayload = $false
		$lastSuccessfulQueuePayload = $null
		if ($GroupAssigneeId -and [string]::IsNullOrWhiteSpace($GroupAssignee)) {
			try {
				$queueById = Get-SwSdQueue -Id $GroupAssigneeId | Select-Object -First 1
				if ($queueById -and $queueById.name) {
					$targetQueueName = [string]$queueById.name
					Write-Verbose "Resolved queue name for id $GroupAssigneeId: $targetQueueName"
				}
			} catch {
			}
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
			$targetQueueId = [int]$GroupAssigneeId
			$body.incident.group_assignee_id = $targetQueueId
			$body.incident.assignee = $null
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
				$targetQueueId = [int]$queue.id
				$body.incident.group_assignee_id = $targetQueueId
				$body.incident.assignee = $null
			} elseif ($group -and $group.id) {
				$msg += "Group Assignee Id: $($group.id)"
				$targetQueueId = [int]$group.id
				$body.incident.group_assignee_id = $targetQueueId
				$body.incident.assignee = $null
			} else {
				$msg += "Group Assignee: $targetGroupName"
				$targetQueueName = $targetGroupName
				$body.incident.group_assignee = @{ name = $targetQueueName }
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
		if (![string]::IsNullOrEmpty($Description)) {
			$msg += "Description"
			$body.incident.description = "$($Description.Trim())"
		}

		if ($body.incident.Keys.Count -eq 0) {
			throw "No valid update fields were constructed for incident $Number."
		}
		$url = $incident.href
		Write-Verbose "Updating incident at URL: $($url)"
		$requestResult = Invoke-IncidentUpdateRequest -Uri $url -Headers $SDSession.headers -IncidentBody $body.incident
		if ($requestResult.Success) {
			Write-Verbose "Incident $Number update HTTP status: $($requestResult.StatusCode)"
		} else {
			Write-Verbose "Primary update failed. HTTP status: $($requestResult.StatusCode)"
			if ($requestResult.ErrorBody) {
				Write-Verbose "Primary update error body: $($requestResult.ErrorBody)"
				if ($requestResult.ErrorBody -match 'group_assignee') {
					$primaryRejectedQueueIdPayload = $true
				}
			}
		}

		if (($targetQueueId -or $targetQueueName) -and -not $requestResult.Success) {
			Write-Verbose "Retrying queue assignment with fallback payloads."
			$fallbackPayloads = @()
			if ($targetQueueId) {
				$fallbackPayloads += @{ assignee = $null; group_assignee = @{ id = $targetQueueId } }
				$fallbackPayloads += @{ assignee = @{ id = $targetQueueId } }
				$fallbackPayloads += @{ assignee = @{ id = $targetQueueId }; group_assignee = @{ id = $targetQueueId } }
				$fallbackPayloads += @{ assignee = $null; group_assignee = @{ name = [string]$targetQueueId } }
				$fallbackPayloads += @{ assignee = @{ name = [string]$targetQueueId } }
				if ($targetQueueName) {
					$fallbackPayloads += @{ assignee = $null; group_assignee = @{ name = $targetQueueName } }
					$fallbackPayloads += @{ assignee = @{ name = $targetQueueName } }
					$fallbackPayloads += @{ assignee = @{ name = $targetQueueName }; group_assignee = @{ name = $targetQueueName } }
				}
				if ($GroupAssignee) {
					$fallbackPayloads += @{ assignee = $null; group_assignee = @{ name = $GroupAssignee.Trim() } }
					$fallbackPayloads += @{ assignee = @{ name = $GroupAssignee.Trim() } }
				}
			} elseif ($targetQueueName) {
				$fallbackPayloads += @{ assignee = $null; group_assignee = @{ name = $targetQueueName } }
				$fallbackPayloads += @{ assignee = @{ name = $targetQueueName } }
			}

			foreach ($fallbackIncident in $fallbackPayloads) {
				$requestResult = Invoke-IncidentUpdateRequest -Uri $url -Headers $SDSession.headers -IncidentBody $fallbackIncident
				if ($requestResult.Success) {
					Write-Verbose "Fallback update succeeded. HTTP status: $($requestResult.StatusCode)"
					$lastSuccessfulQueuePayload = $fallbackIncident
					break
				}
				Write-Verbose "Fallback update failed. HTTP status: $($requestResult.StatusCode)"
				if ($requestResult.ErrorBody) {
					Write-Verbose "Fallback update error body: $($requestResult.ErrorBody)"
				}
			}
		}

		if (-not $requestResult.Success) {
			$finalMessage = "Incident update failed."
			if ($requestResult.StatusCode) {
				$finalMessage += " HTTP status: $($requestResult.StatusCode)."
			}
			if ($requestResult.ErrorBody) {
				$finalMessage += " Response: $($requestResult.ErrorBody)"
			}
			throw $finalMessage
		}

		if ($targetQueueId -or $targetQueueName) {
			$updatedIncident = Get-IncidentByHref -Uri $url -Headers $SDSession.headers
			$match = Test-QueueAssignmentMatch -IncidentObject $updatedIncident -QueueId $targetQueueId -QueueName $targetQueueName
			$queueUpdated = $match.Matched

			if (-not $queueUpdated) {
				Write-Verbose "Queue assignment not confirmed after first payload. Retrying with fallback assignment payload."
				$retryIncident = @{}
				if ($targetQueueId) {
					if ($lastSuccessfulQueuePayload) {
						$retryIncident = $lastSuccessfulQueuePayload
					} elseif ($primaryRejectedQueueIdPayload) {
						$retryIncident.assignee = $null
						$retryIncident.group_assignee = @{ id = $targetQueueId }
					} else {
						$retryIncident.assignee = $null
						$retryIncident.group_assignee_id = $targetQueueId
					}
				} else {
					$retryIncident.assignee = $null
					$retryIncident.group_assignee = @{ name = $targetQueueName }
				}
				$requestResult = Invoke-IncidentUpdateRequest -Uri $url -Headers $SDSession.headers -IncidentBody $retryIncident
				if ($requestResult.Success) {
					Write-Verbose "Retry update HTTP status: $($requestResult.StatusCode)"
				} else {
					Write-Verbose "Retry update failed. HTTP status: $($requestResult.StatusCode)"
					if ($requestResult.ErrorBody) {
						Write-Verbose "Retry update error body: $($requestResult.ErrorBody)"
					}
				}

				$updatedIncident = Get-IncidentByHref -Uri $url -Headers $SDSession.headers
				$match = Test-QueueAssignmentMatch -IncidentObject $updatedIncident -QueueId $targetQueueId -QueueName $targetQueueName
				$queueUpdated = $match.Matched
				Write-Verbose "Post-retry assignment check: group_assignee.id='$($match.GroupId)', group_assignee.name='$($match.GroupName)', assignee.id='$($match.AssigneeId)', assignee.name='$($match.AssigneeName)', assignee.is_user='$($match.AssigneeUser)', matched=$queueUpdated"
			}

			if (-not $queueUpdated) {
				throw "Queue assignment was not confirmed on incident $Number after update attempts."
			}
		}
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
