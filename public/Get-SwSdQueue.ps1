function Get-SwSdQueue {
	<#
	.SYNOPSIS
		Returns assignable queue records.
	.DESCRIPTION
		Returns assignable queue records from the Service Desk API.
		If a dedicated queue endpoint is available in the API entry point, it is used.
		If not, it falls back to filtering groups where the type indicates an assignable queue.
	.PARAMETER Name
		The queue name. If not specified, returns all queues.
	.PARAMETER Id
		The queue ID. If not specified, returns all queues.
	.PARAMETER Force
		Force refresh of the API endpoint list before lookup.
	.EXAMPLE
		Get-SwSdQueue

		Returns all assignable queues.
	.EXAMPLE
		Get-SwSdQueue -Name "IT Help Desk Team Queue"

		Returns queue details for the specified queue name.
	.EXAMPLE
		Get-SwSdQueue -Id 6873849

		Returns queue details for the specified queue id.
	.NOTES
		Queues are represented in some tenants as AssignableQueueGroup entities.
		Reference: https://apidoc.samanage.com/#tag/Group/operation/getGroups
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdQueue.md
	#>
	[CmdletBinding()]
	[OutputType([PSCustomObject])]
	[Alias('Get-SwSdQueues', 'Get-SwSdQueueList')]
	param(
		[parameter(Mandatory = $False)][string]$Name,
		[parameter(Mandatory = $False)][int]$Id,
		[parameter(Mandatory = $False)][switch]$Force
	)
	try {
		$SDSession = Connect-SwSD
		if ($Force) {
			[void](Get-SwSdAPI -Force)
		}

		function Expand-EndpointRecords {
			param([parameter(Mandatory = $false)]$InputObject)
			if ($null -eq $InputObject) { return @() }
			if ($InputObject -is [System.Array]) {
				$items = @()
				foreach ($entry in $InputObject) {
					$items += @(Expand-EndpointRecords -InputObject $entry)
				}
				return $items
			}

			foreach ($propertyName in @('assignment_queues','assignable_queues','queues','groups','data','items')) {
				if ($InputObject.PSObject.Properties[$propertyName]) {
					return @(Expand-EndpointRecords -InputObject $InputObject.$propertyName)
				}
			}

			foreach ($propertyName in @('assignment_queue','assignable_queue','queue','group')) {
				if ($InputObject.PSObject.Properties[$propertyName]) {
					return @(Expand-EndpointRecords -InputObject $InputObject.$propertyName)
				}
			}

			return @($InputObject)
		}

		function Get-InnerGroupRecord {
			param([parameter(Mandatory = $false)]$Record)
			if ($null -eq $Record) { return $null }
			if ($Record.group) { return $Record.group }
			if ($Record.queue) { return $Record.queue }
			return $Record
		}

		function Get-QueueLikeGroups {
			param([parameter(Mandatory = $false)]$InputGroups)
			$allGroups = @($InputGroups | ForEach-Object { Get-InnerGroupRecord -Record $_ } | Where-Object { $_ })

			$candidateIds = New-Object 'System.Collections.Generic.HashSet[string]'

			foreach ($apiName in @('Categories List', 'Sites List', 'Departments List', 'Change Catalogs List', 'Catalog Items List')) {
				try {
					$items = getApiListOrItem -ApiName $apiName -PerPage 100
					foreach ($item in @($items)) {
						$record = Get-InnerGroupRecord -Record $item
						if ($record.default_group_assignee_id) {
							[void]$candidateIds.Add([string]$record.default_group_assignee_id)
						}
						if ($record.category -and $record.category.default_group_assignee_id) {
							[void]$candidateIds.Add([string]$record.category.default_group_assignee_id)
						}
						if ($record.site -and $record.site.default_group_assignee_id) {
							[void]$candidateIds.Add([string]$record.site.default_group_assignee_id)
						}
						if ($record.department -and $record.department.default_group_assignee_id) {
							[void]$candidateIds.Add([string]$record.department.default_group_assignee_id)
						}
						if ($record.change_catalog -and $record.change_catalog.default_group_assignee_id) {
							[void]$candidateIds.Add([string]$record.change_catalog.default_group_assignee_id)
						}
						if ($record.catalog_item -and $record.catalog_item.default_group_assignee_id) {
							[void]$candidateIds.Add([string]$record.catalog_item.default_group_assignee_id)
						}
					}
				} catch {
					Write-Verbose "Candidate lookup failed for $apiName"
				}
			}

			try {
				$incidents = getApiListOrItem -ApiName 'Helpdesk Incidents List' -PerPage 100
				foreach ($incident in @($incidents)) {
					$inc = if ($incident.incident) { $incident.incident } else { $incident }
					if ($inc.group_assignee -and $inc.group_assignee.id) { [void]$candidateIds.Add([string]$inc.group_assignee.id) }
					if ($inc.assignee -and $inc.assignee.is_user -eq $false -and $inc.assignee.id) { [void]$candidateIds.Add([string]$inc.assignee.id) }
				}
			} catch {
				Write-Verbose "Incident candidate lookup failed"
			}

			$queueLike = @(
				$allGroups | Where-Object {
					$g = $_
					$idMatch = $g.id -and $candidateIds.Contains([string]$g.id)
					$typeMatch = ([string]$g.type -match '(?i)queue') -or ($g.avatar -and [string]$g.avatar.klass -match '(?i)queue')
					$assignableMatch = ($g.available_for_assignment -eq $true) -or ($g.can_be_available_for_assignment -eq $true)
					$idMatch -or $typeMatch -or $assignableMatch
				}
			)

			if ($queueLike.Count -eq 0) {
				$queueLike = @($allGroups | Where-Object { [string]$_.name -match '(?i)queue' })
			}

			@(
				$queueLike |
				Where-Object { $_ -and $_.id } |
				Group-Object -Property id |
				ForEach-Object { $_.Group | Select-Object -First 1 }
			)
		}

		function Get-QueueEndpointGroups {
			param([parameter(Mandatory = $false)][string]$MatchName)

			$urls = @(
				"$($SDSession.apiurl)/assignment_queues.json?per_page=100",
				"$($SDSession.apiurl)/assignable_queues.json?per_page=100",
				"$($SDSession.apiurl)/queues.json?per_page=100"
			)

			$records = @()
			foreach ($url in $urls) {
				try {
					Write-Verbose "Trying endpoint: $url"
					$response = getApiResponseByURL -URL $url
					$records += @(Expand-EndpointRecords -InputObject $response | ForEach-Object { Get-InnerGroupRecord -Record $_ })
				} catch {
					Write-Verbose "Endpoint failed: $url"
				}
			}

			$records = @(
				$records |
				Where-Object { $_ -and ($_.id -or $_.name) } |
				Group-Object -Property { if ($_.id) { "id:$($_.id)" } else { "name:$($_.name)" } } |
				ForEach-Object { $_.Group | Select-Object -First 1 }
			)

			if (![string]::IsNullOrWhiteSpace($MatchName)) {
				$exact = @($records | Where-Object { $_.name -and $_.name -ieq $MatchName })
				if ($exact.Count -gt 0) { return $exact }
				return @($records | Where-Object { $_.name -and $_.name -like "*$MatchName*" })
			}

			return $records
		}

		if ($Id) {
			$byId = Get-SwSdGroup -Id $Id | ForEach-Object { Get-InnerGroupRecord -Record $_ }
			if ($byId) { return $byId }
			return
		}

		if (![string]::IsNullOrWhiteSpace($Name)) {
			$endpointByName = Get-QueueEndpointGroups -MatchName $Name
			if ($endpointByName -and @($endpointByName).Count -gt 0) { return $endpointByName }

			$byName = Get-SwSdGroup -Name $Name | ForEach-Object { Get-InnerGroupRecord -Record $_ }
			if ($byName) { return $byName }

			$groups = @(Get-SwSdGroup | ForEach-Object { Get-InnerGroupRecord -Record $_ })
			$queues = Get-QueueLikeGroups -InputGroups $groups
			$nameExact = $queues | Where-Object { $_.name -ieq $Name }
			if ($nameExact) { return $nameExact }
			return $queues | Where-Object { $_.name -like "*$Name*" }
		}

		$endpointQueues = Get-QueueEndpointGroups
		if ($endpointQueues -and @($endpointQueues).Count -gt 0) { return $endpointQueues }
		Write-Verbose "No records returned from queue endpoints. Returning no results for list mode."
		@()
	} catch {
		[pscustomobject]@{
			Status   = 'Error'
			Activity = $($_.CategoryInfo.Activity -join (';'))
			Message  = $($_.Exception.Message -join (';'))
			Trace    = $($_.ScriptStackTrace -join (';'))
		}
	}
}
