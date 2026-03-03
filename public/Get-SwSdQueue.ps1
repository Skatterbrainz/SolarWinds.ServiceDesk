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

		function Expand-QueueRecords {
			param([parameter(Mandatory = $false)]$InputObject)
			if ($null -eq $InputObject) { return @() }
			if ($InputObject -is [System.Array]) { return @($InputObject) }
			if ($InputObject.PSObject.Properties['assignable_queues']) { return @($InputObject.assignable_queues) }
			if ($InputObject.PSObject.Properties['queues']) { return @($InputObject.queues) }
			if ($InputObject.PSObject.Properties['groups']) { return @($InputObject.groups) }
			if ($InputObject.PSObject.Properties['data']) { return @($InputObject.data) }
			if ($InputObject.PSObject.Properties['items']) { return @($InputObject.items) }
			if ($InputObject.PSObject.Properties['group']) { return @($InputObject.group) }
			if ($InputObject.PSObject.Properties['queue']) { return @($InputObject.queue) }
			if ($InputObject.PSObject.Properties['assignable_queue']) { return @($InputObject.assignable_queue) }
			return @($InputObject)
		}

		function Test-IsQueue {
			param([parameter(Mandatory = $false)]$Record)
			if ($null -eq $Record) { return $false }
			if ($Record.type -eq 'AssignableQueueGroup') { return $true }
			if ($Record.avatar -and $Record.avatar.klass -eq 'AssignableQueueGroup') { return $true }
			if ($Record.avatar -and $Record.avatar.type -eq 'queue') { return $true }
			if ($Record.type -match '(?i)queue') { return $true }
			if ($Record.avatar -and $Record.avatar.klass -match '(?i)queue') { return $true }
			if ($Record.name -match '(?i)\bqueue\b') { return $true }
			return $false
		}

		$records = @()

		$apiList = Get-SwSdAPI -Force:$Force
		$queueEndpoints = @(
			$apiList | Where-Object { $_.href -match '(?i)assignable_queues' -or $_.name -match '(?i)assignable\s*queues?' } | Select-Object -ExpandProperty href
		)
		$queueEndpoints += "$($SDSession.apiurl)/assignable_queues.json"
		$queueEndpoints = $queueEndpoints | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique

		foreach ($endpoint in $queueEndpoints) {
			try {
				Write-Verbose "Trying endpoint: $endpoint"
				if ($Id) {
					$itemUrl = "$(($endpoint -replace '\\.json$',''))/$Id.json"
					$item = getApiResponseByURL -URL $itemUrl
					$expanded = Expand-QueueRecords -InputObject $item
					if ($expanded.Count -gt 0) { $records += $expanded }
				} else {
					$listUrl = if ($endpoint -match '\?') { "$endpoint&per_page=100" } else { "$endpoint?per_page=100" }
					$list = getApiResponseByURL -URL $listUrl
					$expanded = Expand-QueueRecords -InputObject $list
					if ($expanded.Count -gt 0) { $records += $expanded }
				}
			} catch {
				Write-Verbose "Endpoint failed: $endpoint"
			}
		}

		try {
			if ($Id) {
				$groupById = Get-SwSdGroup -Id $Id
				if ($groupById) { $records += (Expand-QueueRecords -InputObject $groupById) }
			} else {
				$groupList = Get-SwSdGroup
				if ($groupList) { $records += (Expand-QueueRecords -InputObject $groupList) }
			}
		} catch {
			Write-Verbose "Group fallback failed: $($_.Exception.Message)"
		}

		$records = @(
			$records |
			Where-Object { $_ -and $_.id } |
			Group-Object -Property id |
			ForEach-Object { $_.Group | Select-Object -First 1 }
		)

		if ($Id) {
			$idMatch = $records | Where-Object { [string]$_.id -eq [string]$Id }
			if ($idMatch) {
				if (![string]::IsNullOrEmpty($Name)) {
					return $idMatch | Where-Object { $_.name -eq $Name }
				}
				return $idMatch
			}
		}

		$queues = $records | Where-Object { Test-IsQueue -Record $_ }

		if (!$Id -and (!$queues -or $queues.Count -eq 0)) {
			Write-Verbose "No explicit queue markers found; using fallback candidate records"
			$queues = $records
		}

		if (![string]::IsNullOrEmpty($Name)) {
			$nameExact = $queues | Where-Object { [string]$_.name -ieq [string]$Name }
			if ($nameExact) {
				$queues = $nameExact
			} else {
				$queues = $queues | Where-Object { [string]$_.name -like "*$Name*" }
			}
		}
		$queues
	} catch {
		[pscustomobject]@{
			Status   = 'Error'
			Activity = $($_.CategoryInfo.Activity -join (';'))
			Message  = $($_.Exception.Message -join (';'))
			Trace    = $($_.ScriptStackTrace -join (';'))
		}
	}
}
