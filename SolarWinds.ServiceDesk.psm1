<#
.NOTES
	Version 1.0.0 - 2025-02-22

	Reference: https://apidoc.samanage.com/
	For better ODATA query syntax documentation, see the Loggly API reference:
	https://documentation.solarwinds.com/en/success_center/loggly/content/admin/search-query-language.htm
	Web portal: advocatesinc.samanage.com
#>
function Connect-SwSD {
	<#
	.DESCRIPTION
		Creates a new SolarWinds Service Desk session.
	.PARAMETER ApiToken
		The authentication API token.
	.PARAMETER ApiUrl
		The API URL. Default is "https://api.samanage.com".
	.PARAMETER ApiVersion
		The API version. Default is "v2.1".
	.PARAMETER ApiFormat
		The API format: json or xml. Default is "json".
	.PARAMETER Refresh
		Refresh the session.
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$ApiToken,
		[parameter()][string]$ApiUrl = "https://api.samanage.com",
		[parameter()][string]$ApiVersion = "v2.1",
		[parameter()][string][ValidateSet('json','xml')]$ApiFormat = "json",
		[parameter()][switch]$Refresh
	)
	try {
		if ($SDSession -and !$Refresh.IsPresent) {
			$SDSession
		} else {			
			if (![string]::IsNullOrWhiteSpace($ApiToken)) {
				$global:SwSdToken = $ApiToken
			} else {
				if ($env:SWSDToken) {
					$global:SwSdToken = $env:SWSDToken
				} else {
					throw "API Token not provided or defined in the environment.(env: SWSDToken)"
				}
			}
			$headers = @{
				"X-Samanage-Authorization" = "Bearer $($global:SwSdToken)"
				"Accept" = "application/vnd.samanage.$($ApiVersion)+$($ApiFormat)"
				"Content-Type" = "application/json"
			}
			$global:SDSession = @{
				headers = $headers
				apiurl  = $apiurl
				timeSet = (Get-Date)
			}
			$SDSession
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SwSDAPI {
	<#
	.DESCRIPTION
		Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.
		Caches list to global variable $SDAPIList, to minimize API calls.
	.PARAMETER Name
		The name of the API to retrieve. If not specified, returns the list of available APIs.
	.EXAMPLE
		Get-SwSDAPI -Name "Incidents List"
		Returns the URL for the Incidents List API
	.EXAMPLE
		Get-SwSDAPI
		Returns all API URLs
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$Name
	)
	$Session = Connect-SwSD
	if (!$SDAPIList) {
		Write-Verbose "API list not cached"
		$url = "$($Session.apiurl)/api.json"
		Write-Verbose "Url = $url"
		$apilist = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		if ($apilist.Count -gt 0) {
			# the search api is not included in the list for some reason, so append it manually
			$apilist += @([pscustomobject]@{name='Search'; href='https://api.samanage.com/search.json'})
		}
		$global:SDAPIList = $apilist
	} else {
		Write-Verbose "API list cached"
	}
	if (![string]::IsNullOrEmpty($Name)) {
		$SDAPIList | Where-Object {$_.name -eq $Name} | Select-Object -ExpandProperty href
	} else {
		$SDAPIList
	}
}

function Get-SwSDIncident {
	<#
	.DESCRIPTION
		Returns a Service Desk incident for the specified incident Number or ID + name.
	.PARAMETER Number
		The incident number.
	.PARAMETER Id
		The incident ID.
	.PARAMETER Name
		The incident name. Required if Id is provided.
	.EXAMPLE
		Get-SwSDIncident -Number 12345
		Returns the incident record for incident number 12345.
	.EXAMPLE
		Get-SwSDIncident -Id 123456789 -Name "Incident Name"
		Returns the incident record for incident ID 12345 with the specified name.
	#>
	[CmdletBinding()]
	param (
		[parameter(ParameterSetName='Number')][string]$Number,
		[parameter(ParameterSetName='ID')][int32]$Id,
		[parameter(ParameterSetName='ID')][string]$Name
	)
	try {
		$Session  = Connect-SwSD
		if (![string]::IsNullOrEmpty($Number)) {
			$baseurl = Get-SwSDAPI -Name "Search"
			$url = "$($baseurl)?q=number:$Number"
		} elseif (![string]::IsNullOrEmpty($Id) -and ![string]::IsNullOrEmpty($Name)) {
			$baseurl = Get-SwSDAPI -Name "Helpdesk Incidents List"
			$idx = Get-SwSDIncidentLink -Number $Id -Name $Name
			$url = "$($baseurl.Replace('.json',''))/$idx"
		} else {
			throw "Either the Number or ID + Name must be provided."
		}
		Write-Verbose "url = $url"
		$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
	} catch {
		$result = [pscustomobject]@{
			Status    = 'Error'
			Activity  = $($_.CategoryInfo.Activity -join (";"))
			Message   = $($_.Exception.Message -join (";"))
			Trace     = $($_.ScriptStackTrace -join (";"))
			Incident  = $IncidentNumber
		}
	} finally {
		$result
	}
}

function Get-SwSDIncidents {
	<#
	.DESCRIPTION
		Returns a list of Service Desk incidents based on the specified request type and status.
	.PARAMETER RequestType
		The type of request: Provision or Termination. Default is Provision.
	.PARAMETER Status
		The status of the request: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled. Default is Pending Assignment.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER PageCount
		The number of pages to return. Default is 0 (all pages).
	.PARAMETER IncidentNameProvision
		The name of the incident for provisioning requests. Default is 'New Users are entered into the IT Authorization Form'.
	.PARAMETER IncidentNameTermination
		The name of the incident for termination requests. Default is 'Employee Terminations'.
	#>
	[CmdletBinding()]
	param (
		[parameter()][string][ValidateSet('Provision','Termination')]$RequestType = "Provision",
		[parameter()][string]
		[ValidateSet('Awaiting Input','Assigned','Closed','On Hold','Pending Assignment','Scheduled')]$Status = 'Pending Assignment',
		[parameter()][int]$PageLimit = 100,
		[parameter()][int]$PageCount = 0
	)
	try {
		$Session = Connect-SwSD	
		$baseurl = Get-SwSDAPI -Name "Search"
		if ([string]::IsNullOrEmpty($baseurl)) { throw "API Url not found." }
		$searchCriteria = "state:`"$($Status)`" AND name:`"$($IncName)`""
		$encodedSearch  = [System.Web.HttpUtility]::UrlEncode($searchCriteria)
		$url = "$($baseurl)?per_page=$PageLimit&q=$($encodedSearch)"
		Write-Verbose "url: $url"
		$incidents = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		if ($responseHeaders) {
			Write-Verbose "getting response headers"
			[int]$totalCount = $responseHeaders.'X-Total-Count'
			[int]$totalPages = $responseHeaders.'X-Total-Pages'
			Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
			if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
				$totalPages = $PageCount
			}
			for ($i = 2; $i -le $totalPages; $i++) {
				$url = "$url&page=$i"
				Write-Verbose "url: $url"
				$incidents += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
			}
		}
		$result = $incidents
	} catch {
		$result = [pscustomobject]@{
			Status    = 'Error'
			Activity  = $($_.CategoryInfo.Activity -join (";"))
			Message   = $($_.Exception.Message -join (";"))
			Trace     = $($_.ScriptStackTrace -join (";"))
			Incident  = $IncidentNumber
		}
	} finally {
		$result
	}
}

function Get-SwSDIncidentLink {
	<#
	.DESCRIPTION
		Generates a unique URL for the specified incident ID and name.
	.PARAMETER Number
		The incident number.
	.PARAMETER Name
		The incident name.
	.EXAMPLE
		Get-SwSDIncidentLink -Number 149737766 -Name "NH 2/18/25 Abenaa Ampem MBL WKR PKG #1 3000000"
		Returns: 149737766-nh-2-18-25-abenaa-ampem-mbl-wkr-pkg-1-3000000.json
	.NOTES
		This is also the tail end of the [href] property of an incident.
	#>
	param (
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Name
	)
	Write-Output "$($Number)-$(($Name.Trim() -replace ' ','-' -replace '#','' -replace '/','-').ToLower()).json"
}

#region Incident Request Data
# Get user provision request table data from incident record

# Get user termination request table data from incident record (existing, email list)
function Export-SwSDIncidentRequest {
	<#
	.DESCRIPTION
		Exports the incident request data to a file.
	.PARAMETER Number
		The incident number.
	.PARAMETER SaveToFile
		Save the request data to a file.
	.PARAMETER OutputPath
		The path to save the file. Default is the user's Documents folder.
	.PARAMETER Show
		Display the exported HTML request data in the default web browser.
	.EXAMPLE
		Export-SwSDIncidentRequest -Number 12345 -SaveToFile
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter()][switch]$SaveToFile,
		[parameter()][string]$OutputPath,
		[parameter()][switch]$Show
	)
	$incident = Get-SwSDIncident -Number $Number -IncludeDescription -NoRequestData
	if ($incident) {
		if ($SaveToFile.IsPresent -and [string]::IsNullOrEmpty($OutputPath)) {
			$OutputPath = (Resolve-Path (Join-Path "~" "Documents")).Path
			$filepath = Join-Path $OutputPath "incident-$($Number)_description.html"
			$incident.description.Trim() | Out-File -FilePath $filepath -Encoding utf8 -Force
			Write-Host "Incident $Number request data exported to: $filepath"
			if ($Show.IsPresent) {
				Invoke-Item $filepath
			}
		} else {
			$incident.description.Trim()
		}
	} else {
		Write-Warning "Incident $Number not found."
	}
}

function Update-SwSDIncident {
	<#
	.DESCRIPTION
		Updates the specified incident record with the provided assignee and/or status.
	.PARAMETER Number
		The incident number.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Status
		The status of the incident: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled.
		The default status is 'Assigned'.
	.EXAMPLE
		Update-SwSDIncident -Number 12345 -Assignee "jsmith@contoso.org" -Status "Pending Assignment"
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter()][string][Alias('Email')]$Assignee,
		[parameter()][string][ValidateSet('Awaiting Input','Assigned','Closed','On Hold','Pending Assignment','Scheduled')][Alias('State')]$Status = 'Pending Assignment'
	)
	try {
		if ([string]::IsNullOrEmpty($Assignee) -and [string]::IsNullOrEmpty($Status)) {
			throw "Assignee or Status must be provided."
		}
		$Session = Connect-SwSD
		Write-Verbose "Requesting Incident $Number"
		$incident = Get-SwSDIncident -Number $Number -NoRequestData
		if (!$incident) {
			throw "Incident $Number not found."
		}
		$msg = ""
		$body = @{incident = @{}}

		if (![string]::IsNullOrEmpty($Status)) {
			$msg += "Status: $($Status.Trim())"
			$body.incident.state = "$($Status.Trim())"
		}
		if (![string]::IsNullOrEmpty($Assignee)) {
			Write-Verbose "Verifying User $Assignee"
			$user = Get-SwSDUser -Email $Assignee
			if (!$user) {
				throw "User $Assignee not found."
			}
			$msg += "Assignee: $($Assignee.Trim())"
			$body.incident.assignee = @{
				email = "$($Assignee.Trim())"
			}
		}
		$json = $body | ConvertTo-Json
		Write-Verbose "Updating incident at URL: $($incident.href)"
		$response = Invoke-RestMethod -Method PUT -Uri $($incident.href) -ContentType "application/json" -Headers $Session.headers -Body $json
		Write-Verbose "Incident $Number updated: $($response.state)"
		$result = [pscustomobject]@{
			Status   = "Success"
			State    = $Status
			Assignee = $Assignee
		}
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
#endregion

#region Tasks
function Get-SwSDTask {
	<#
	.DESCRIPTION
		Returns the Service Desk task records for the specified Task URL or Incident Number.
	.PARAMETER TaskURL
		The URL of the task. If provided, returns the specific task record.
	.PARAMETER IncidentNumber
		The incident number. If provided without TaskURL, returns all task records for the specified incident.
	.EXAMPLE
		Get-SwSDTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
		Returns the task record for the specified Task URL.
	.EXAMPLE
		Get-SwSDTask -IncidentNumber "12345"
		Returns the task records for the Incident record having the number 12345.
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$TaskURL,
		[parameter()][string]$IncidentNumber
	)
	try {
		if ([string]::IsNullOrEmpty($TaskURL) -and [string]::IsNullOrEmpty($IncidentNumber)) {
			throw "Either the TaskURL or IncidentNumber must be provided."
		}
		$Session = Connect-SwSD
		if (![string]::IsNullOrWhiteSpace($TaskURL)) {
			$response = Invoke-RestMethod -Method GET -Uri $TaskURL.Trim() -Headers $Session.headers
		} elseif (![string]::IsNullOrWhiteSpace($IncidentNumber)) {
			$incident = Get-SwSDIncident -Number $IncidentNumber -NoRequestData
			if ($null -ne $incident) {
				$response = @()
				$tasks = $incident.tasks
				Write-Verbose "$($tasks.Count) tasks found for Incident $IncidentNumber."
				foreach ($task in $tasks) {
					$TaskURL = $task.href
					Write-Verbose "Task URL: $taskUrl"
					$response += Invoke-RestMethod -Method GET -Uri $TaskURL -Headers $Session.headers
				}
			} else {
				throw "Incident $IncidentNumber not found."
			}
		} else {
			throw "Either the TaskURL or IncidentNumber must be provided."
		}
	} catch {
		Write-Error $_.Exception.Message
	} finally {
		$response
	}
}

function New-SwSDTask {
	<#
	.DESCRIPTION
		Creates a new task for the specified incident number.
	.PARAMETER IncidentNumber
		The incident number.
	.PARAMETER Name
		The task name.
	.PARAMETER Assignee
		The task assignee email address.
	.PARAMETER IsComplete
		The task completion status. Default is False.
	.PARAMETER DueDateOffsetDays
		The number of days to offset the due date. Default is 14 days.
	.EXAMPLE
		New-SwSDTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com"
	.NOTES
		Refer to https://apidoc.samanage.com/#tag/Task/operation/createTask
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$IncidentNumber,
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Name,
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Assignee,
		[parameter()][boolean]$IsComplete = $False,
		[parameter()][int]$DueDateOffsetDays = 14
	)
	try {
		$Session  = Connect-SwSD
		$incident = Get-SwSDIncident -Number $IncidentNumber
		if (!$incident) { throw "Incident $IncidentNumber not found." }
		$baseurl = Get-SwSDAPI -Name "Helpdesk Incidents List"
		$url  = "$($baseurl.replace('.json',''))/$($incident.id)/tasks"
		Write-Verbose "Tasks URL: $url"
		Write-Verbose "Verifying User $Assignee"
		$user = Get-SwSDUser -Email $Assignee
		if (!$user) {
			throw "User $Assignee not found."
		}
		$dueDate = (Get-Date).AddDays($DueDateOffsetDays).ToString("MMM dd, yyyy")
		$body = @{
			"task" = @{
				"name" = $Name.Trim()
				"assignee" = @{
					"email" = $Assignee.Trim()
				}
				"due_at" = $dueDate
				"is_complete" = $IsComplete
			}
		} | ConvertTo-Json
		Write-Verbose "Creating task: $json"
		#curl -H "X-Samanage-Authorization: Bearer $token" -H "Accept: application/vnd.samanage.v2.1+json" -H "Content-Type: application/json" -X POST $url -d $json
		$response = Invoke-RestMethod -Method POST -Uri $url -ContentType "application/json" -Headers $Session.headers -Body $body #-ErrorAction Stop
		$response
	} catch {
		if ($_.Exception.Message -notmatch '406') {
			Write-Error $_.Exception.Message
		}
	}
}

function Remove-SwSDTask {
	<#
	.DESCRIPTION
		Deletes the task for the specified Task URL.
	.PARAMETER TaskURL
		The URL of the task.
	.EXAMPLE
		Remove-SwSDTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
		Deletes the specified incident task record.
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$TaskURL
	)
	$Session  = Connect-SwSD
	$response = Invoke-RestMethod -Method DELETE -Uri $TaskURL -Headers $Session.headers
	$response
}

function Update-SwSDTask {
	<#
	.DESCRIPTION
		Updates the specified task record with the provided assignee and/or status.
	.PARAMETER TaskURL
		The URL of the task.
	.PARAMETER Assignee
		The email address of the assignee.
	.PARAMETER Completed
		Mark the task as completed.
	.EXAMPLE
		Update-SwSDTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Completed
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$TaskURL,
		[parameter()][string][Alias('Email')]$Assignee,
		[parameter()][switch]$Completed
	)
	$Session = Connect-SwSD
	$task    = Invoke-RestMethod -Method GET -Uri $TaskURL -Headers $Session.headers
	if ($task) {
		$body    = @{task = @{}}
		if (![string]::IsNullOrEmpty($Assignee)) {
			$body.task.assignee = @{email = $Assignee}
		}
		if ($Completed.IsPresent) {
			$body.task.is_complete = $true
		}
		$json = $body | ConvertTo-Json
		$response = Invoke-RestMethod -Method PUT -Uri $TaskURL -ContentType "application/json" -Headers $Session.headers -Body $json
		$response
	} else {
		Write-Error "Task not found with URL: $TaskURL"
	}
}

#endregion

#region Comments
function Get-SwSDComments {
	<#
	.SYNOPSIS
		Returns the comments for the specified incident.
	.DESCRIPTION
		Returns the comments for the specified incident.
	.PARAMETER IncidentNumber
		The incident number.
	.EXAMPLE
		Get-SwSDComments -IncidentNumber 12345
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$IncidentNumber
	)
	try {
		$Session     = Connect-SwSD
		$incident    = Get-SwSDIncident -Number $IncidentNumber -NoRequestData
		if ($incident) {
			$baseurl  = (Get-SwSDAPI -Name "Helpdesk Incidents List") -replace ".json", ""
			$url      = "$($baseurl)/$($incident.id)/comments.json"
			Write-Verbose "Url: $url"
			$params = @{
				Uri         = $url
				Method      = 'GET'
				ContentType = "application/json"
				Headers     = $Session.headers
				ErrorAction = 'Stop'
			}
			$response    = Invoke-RestMethod @params
			$result      = $response
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
		}
	} finally {
		$result
	}
}

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

#endregion

#region Users, Roles, Groups
function Get-SwSDUser {
	<#
	.DESCRIPTION
		Returns the user record for the specified email address.
	.PARAMETER Email
		The user's email address.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER PageCount
		The number of pages to return. Default is 10.
	.PARAMETER NoProgress
		Suppress the progress indicator.
	.EXAMPLE
		Get-SwSDUser -Email "jsmith@contoso.com"
	#>
	[CmdletBinding()]
	param(
		[parameter()][Alias('Name')][string]$Email,
		[parameter()][int]$PageLimit = 100,
		[parameter()][int]$PageCount = 10,
		[parameter()][switch]$NoProgress
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSDAPI -Name "Users List"
		if (![string]::IsNullOrEmpty($Email)) {
			$url    = "$($baseurl)?email=$Email"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		} else {
			$url    = "$($baseurl)?per_page=$PageLimit"
			$users  = @()
			$users  += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
			[int]$totalCount = $responseHeaders.'X-Total-Count'[0]
			[int]$totalPages = $responseHeaders.'X-Total-Pages'[0]
			Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
			if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
				$totalPages = $PageCount
			}
			for ($i = 2; $i -le $totalPages; $i++) {
				$url = "$($baseurl)?per_page=$PageLimit&page=$i"
				if (!$NoProgress.IsPresent) {
					Write-Progress -Activity "Retrieving User Data" -Status "Page $i of $totalPages" -PercentComplete ($i / $totalPages * 100) -Id 0
				}
				$users += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders
			}
			if (!$NoProgress.IsPresent) {
				Write-Progress -Activity "Retrieving User Data" -Status "Completed" -PercentComplete 100 -Id 0
			}
			$result = $users | where-Object {$_.disabled -ne $true}
		}
		Write-Output $result
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SwSDRole {
	<#
	.SYNOPSIS
		Returns the role record for the specified role name.
	.DESCRIPTION
		Returns the role record for the specified role name or all roles.
	.PARAMETER Name
		The role name. If not specified, returns all roles.
	.EXAMPLE
		Get-SwSDRole -Name "Admin"
		Returns information for the Admin role.
	.EXAMPLE
		Get-SwSDRole
		Returns all roles.
	#>
	[CmdletBinding()]
	param(
		[parameter()][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSDAPI -Name "Roles List"
		$url     = "$($baseurl)?per_page=100"
		$roles   = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
		if (![string]::IsNullOrEmpty($Name)) {
			$roles | Where-Object {$_.name -eq $Name}
		} else {
			$roles
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SwSDGroup {
	<#
	.SYNOPSIS
		Returns the group record for the specified group name.
	.DESCRIPTION
		Returns the group record for the specified group name or all groups.
	.PARAMETER Name
		The group name. If not specified, returns all groups.
	.EXAMPLE
		Get-SwSDGroup -Name "Admins"
		Returns information for the Admins group.
	.EXAMPLE
		Get-SwSDGroup
		Returns all groups.
	#>
	[CmdletBinding()]
	param(
		[parameter()][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$url     = Get-SwSDAPI -Name "Groups List"
		$url     = "$($url)?per_page=100"
		$groups  = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
		if (![string]::IsNullOrEmpty($Name)) {
			$groups | Where-Object {$_.name -eq $Name}
		} else {
			$groups
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SwSDGroupMembers {
	<#
	.SYNOPSIS
		Returns the members of the specified group.
	.DESCRIPTION
		Returns the members of the specified group.
	.PARAMETER Name
		The group name.
	.EXAMPLE
		Get-SwSDGroupMembers -Name "Admins"
		Returns the members of the Admins group.
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string]$Name
	)
	$group = Get-SwWDGroup -Name $Name
	$group.memberships
}
#endregion

#region Hardware, Software, Catalog Items
function Get-SwSDHardware {
	<#
	.SYNOPSIS
		Returns the hardware records for the specified ID or all hardware.
	.DESCRIPTION
		Returns the hardware records for the specified ID or all hardware.
	.PARAMETER Id
		The hardware ID.
	.PARAMETER PageCount
		The number of pages to return. Default is 0 (all pages).
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.PARAMETER NoProgress
		Suppress the progress indicator.
	.EXAMPLE
		Get-SwSDHardware -Id 12345
		Returns the hardware record for the specified ID.
	.EXAMPLE
		Get-SwSDHardware -PageCount 5
		Returns the first 5 pages of hardware records.
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$Id,
		[parameter()][int]$PageCount = 0,
		[parameter()][int]$PageLimit = 100,
		[parameter()][switch]$NoProgress
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSDAPI -Name "Computers List"
		if (![string]::IsNullOrEmpty($Id)) {
			$url = "$($baseurl)/$Id.json"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
			Write-Output $hardwares
			break
		} else {
			$url = "$($baseurl)?per_page=$PageLimit"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -ErrorAction Stop
			if ($responseHeaders) {
				[int]$totalCount = $responseHeaders.'X-Total-Count'[0]
				[int]$totalPages = $responseHeaders.'X-Total-Pages'[0]
				if ($PageCount -gt 0 -and $PageCount -lt $totalPages) {
					$totalPages = $PageCount
				}
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				for ($i = 2; $i -le $totalPages; $i++) {
					$url = "$($baseurl)?per_page=$PageLimit&page=$i"
					try {
						$result += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
						if (!$NoProgress.IsPresent) {
							Write-Progress -Activity "Retrieving hardware" -Status "Page $i of $totalPages ($totalCount total items)" -PercentComplete ($i / $totalPages * 100) -Id 0
						}
					} catch {
						continue
					}
				}
				if (!$NoProgress.IsPresent) {
					Write-Progress -Activity "Retrieving hardware" -Status "Completed" -PercentComplete 100 -Id 0
				}
			}
		}
		Write-Output $result
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SwSDCatalogItem {
	<#
	.SYNOPSIS
		Returns the catalog item records for the specified ID or all catalog items.
	.DESCRIPTION
		Returns the catalog item records for the specified ID or all catalog items.
	.PARAMETER Id
		The catalog item ID.
	.PARAMETER Name
		The catalog item name.
	.PARAMETER Tag
		The catalog item tag.
	.PARAMETER PageLimit
		The maximum number of records to return per page. Default is 100.
	.EXAMPLE
		Get-SwSDCatalogItem -Id 12345
		Returns the catalog item record for the specified ID.
	.EXAMPLE
		Get-SwSDCatalogItem -Name "New User"
		Returns the catalog item record for the specified name.
	#>
	[CmdletBinding()]
	param(
		[parameter()][string]$Id,
		[parameter()][string]$Name,
		[parameter()][string]$Tag,
		[parameter()][int]$PageLimit = 100
	)
	try {
		$Session = Connect-SwSD
		$baseurl = Get-SwSDAPI -Name "Catalog Items List"
		#Write-Verbose "Url: $url"
		if (![string]::IsNullOrEmpty($Id)) {
			$url = "$($baseurl.Replace('.json',''))/$Id.json"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		} elseif (![string]::IsNullOrEmpty($Name) -and ($Id -gt 0)) {
			$url = "$($baseurl.Replace('.json',''))/$Id-$($Name.ToLower().Replace(' ','-')).json"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop
		} else {
			$url = "$($baseurl)?per_page=$PageLimit"
			Write-Verbose "Url: $url"
			$result = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop -ResponseHeadersVariable responseHeaders
			Write-Verbose "$($result.Count) items returned."
			if ($responseHeaders) {
				[int]$totalCount = $responseHeaders.'X-Total-Count'[0]
				[int]$totalPages = $responseHeaders.'X-Total-Pages'[0]
				Write-Verbose "Total Pages: $totalPages / Total Records: $totalCount"
				for ($i = 2; $i -le $totalPages; $i++) {
					Write-Progress -Activity "Retrieving Catalog Items" -Status "Page $i of $totalPages" -PercentComplete ($i / $totalPages * 100) -Id 0
					$url = "$($baseurl)?per_page=$PageLimit&page=$i"
					$result += Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
				}
				Write-Progress -Activity "Retrieving Catalog Items" -Status "Completed" -PercentComplete 100 -Id 0
			} else {
				Write-Warning "No pages returned."
			}
		}
		Write-Output $result
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SwSDCatalogCategory {
	<#
	.SYNOPSIS
		Returns a catalog category or returns all categories.
	.DESCRIPTION
		Returns a catalog category or returns all categories.
	.PARAMETER Id
		The catalog category ID.
	.PARAMETER Name
		The catalog category name.
	.EXAMPLE
		Get-SwSDCatalogCategories
		Returns the catalog categories.
	.EXAMPLE
		Get-SwSDCatalogCategory -Id 12345
		Returns the catalog category for the specified ID.
	.EXAMPLE
		Get-SwSDCatalogCategory -Name "Mobile Devices"
		Returns the catalog category for the specified name.
	#>
	[CmdletBinding()]
	param(
		[parameter()][int]$Id,
		[parameter()][string]$Name
	)
	try {
		$Session = Connect-SwSD
		$url     = Get-SwSDAPI -Name "Categories List"
		Write-Verbose "Url: $url"
		$response = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop | Sort-Object name
		if ($Id -gt 0) {
			$response | Where-Object {$_.id -eq $Id}
		} elseif (![string]::IsNullOrEmpty($Name)) {
			$response | Where-Object {$_.name -eq $Name}
		} else {
			$response
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}
#endregion
