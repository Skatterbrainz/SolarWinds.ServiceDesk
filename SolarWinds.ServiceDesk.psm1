<#
.NOTES
	Version 1.0.0 - 2025-02-18

	Reference: https://apidoc.samanage.com/
	For better ODATA query syntax documentation, see the Loggly API reference:
	https://documentation.solarwinds.com/en/success_center/loggly/content/admin/search-query-language.htm
	Web portal: advocatesinc.samanage.com
#>
function New-SDSession {
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
				$global:Token = $ApiToken
			} else {
				throw "ApiToken was not provided"
			}
			$headers = @{
				"X-Samanage-Authorization" = "Bearer $($global:Token)"
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

function Import-SDToken {
	param(
		[parameter()][string]$Path = "~/sdtoken.txt"
	)
	if (Test-Path -Path $Path) {
		$global:token = $(Get-Content -Path $Path -Raw -Encoding utf8).Trim()
		Write-Host "Token imported from $Path"
	} else {
		Write-Host "Token file not found: $Path"
		$token = Read-Host "Enter your SolarWinds Service Desk API token"
		if (![string]::IsNullOrEmpty($token)) {
			Set-Content -Path $Path -Value $token.Trim()
			$global:token = $token.Trim()
		} else {
			Write-Warning "No token, no service desk"
			break
		}
	}
	$token
}

function Get-SDAPI {
	<#
	.DESCRIPTION
		Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.
		Caches list to global variable $SDAPIList, to minimize API calls.
	.PARAMETER Name
		The name of the API to retrieve. If not specified, returns the list of available APIs.
	.EXAMPLE
		Get-SDAPI -Name "Incidents List"
		Returns the URL for the Incidents List API
	.EXAMPLE
		Get-SDAPI
		Returns all API URLs
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$Name
	)
	$Session = New-SDSession
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

function Get-SDIncident {
	<#
	.DESCRIPTION
		Returns a Service Desk incident record with RequestData for the specified incident number or ID and name.
	.PARAMETER Number
		The incident number.
	.PARAMETER Id
		The incident ID.
	.PARAMETER Name
		The incident name. Required if Id is provided.
	.PARAMETER IncludeDescription
		Include the incident description in the output.
	.PARAMETER NoRequestData
		Exclude the request data from the output.
	.PARAMETER RequestDataType
		The type of request data to retrieve: Single or Multiple. Default is Single.
	.PARAMETER IncidentNameProvision
		The name of the incident for provisioning requests. Default is 'New Users are entered into the IT Authorization Form'.
	.PARAMETER IncidentNameTermination
		The name of the incident for termination requests. Default is 'Employee Terminations'.
	#>
	[CmdletBinding()]
	param (
		[parameter(ParameterSetName='Number')][string]$Number,
		[parameter(ParameterSetName='ID')][int32]$Id,
		[parameter(ParameterSetName='ID')][string]$Name,
		[parameter()][switch]$IncludeDescription,
		[parameter()][switch]$NoRequestData,
		[parameter()][string][ValidateSet('Single','Multiple')]$RequestDataType = 'Single',
		[parameter()][string]$IncidentNameProvision = 'New Users are entered into the IT Authorization Form',
		[parameter()][string]$IncidentNameTermination = 'Employee Termination Notification',
		[parameter()][string][ValidateSet('Nothing','HTML','JSON')]$Export = 'Nothing',
		[parameter()][string]$ExportPath = "~",
		[parameter()][switch]$Show
	)
	try {
		$Session  = New-SDSession
		if (![string]::IsNullOrEmpty($Number)) {
			$baseurl = Get-SDAPI -Name "Search"
			$url = "$($baseurl)?q=number:$Number"
		} elseif (![string]::IsNullOrEmpty($Id) -and ![string]::IsNullOrEmpty($Name)) {
			$baseurl = Get-SDAPI -Name "Helpdesk Incidents List"
			$idx = Get-SDIncidentLink -Number $Id -Name $Name
			$url = "$($baseurl.Replace('.json',''))/$idx"
		} else {
			throw "Either the Number or ID + Name must be provided."
		}
		Write-Verbose "url = $url"
		$incident = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get
		Write-Verbose "Name: $($incident.name)"
		if ($incident.name -eq $IncidentNameProvision) {
			$requestType = 'Provision'
		} elseif ($incident.name -eq $IncidentNameTermination) {
			$requestType = 'Termination'
		} else {
			throw "Unsupported Request Type: $($incident.name)"
		}
		if (!$NoRequestData.IsPresent) {
			if ($requestType -eq 'Provision') {
				if ($RequestDataType -eq 'Single') {
					Write-Verbose "getting request form data: prov-single"
					$requestData = Get-SDRequestProvSingle -Incident $incident
				} elseif ($RequestDataType -eq 'Multiple') {
					Write-Verbose "getting request form data: prov-multiple"
					$requestData = Get-SDRequestProvBatch -Incident $incident
				}
			} elseif ($requestType -eq 'Termination') {
				if ($RequestDataType -eq 'Single') {
					Write-Verbose "getting request form data: term-single"
					$requestData = Get-SDRequestTermSingle -Incident $incident
				} elseif ($RequestDataType -eq 'Multiple') {
					Write-Verbose "getting request form data: term-multiple"
					$requestData = Get-SDRequestTermMultiple -Incident $incident
				}
			}
			if (!$IncludeDescription.IsPresent) {
				# return everything except description properties
				$incident | Select-Object -Property *, @{ n = 'RequestData'; e = { $requestData }}, @{ n = 'RequestType'; e = { $requestType }} -ExcludeProperty description,description_no_html
			} else {
				$incident | Select-Object -Property *, @{ n = 'RequestData'; e = { $requestData }}, @{ n = 'RequestType'; e = { $requestType }}
			}
			if ($Export -eq 'HTML') {
				$filepath = Join-Path $ExportPath "incident-$($incident.number)_description.html"
				$incident.description | Out-File -FilePath $filepath -Encoding utf8 -Force
				Write-Host "Incident description exported to: $filepath"
				if ($Show.IsPresent) { Invoke-Item $filepath }
			} elseif ($Export -eq 'JSON') {
				$filepath = Join-Path $ExportPath "incident-$($incident.number).json"
				$incident | ConvertTo-Json | Out-File -FilePath $filepath -Encoding utf8 -Force
				Write-Host "Incident description exported to: $filepath"
				if ($Show.IsPresent) { Invoke-Item $filepath }
			}
		} else {
			if (!$IncludeDescription.IsPresent) {
				# return everything except the description properties
				$incident | Select-Object -Property *, @{ n = 'RequestType'; e = { $requestType }} -ExcludeProperty description,description_no_html
			} else {
				$incident | Select-Object -Property *, @{ n = 'RequestType'; e = { $requestType }}
			}
			if ($Export -eq 'HTML') {
				$filepath = Join-Path $ExportPath "incident-$($incident.number)_description.html"
				$incident.description | Out-File -FilePath $filepath -Encoding utf8 -Force
				Write-Host "Incident description exported to: $filepath"
				if ($Show.IsPresent) { Invoke-Item $filepath }
			} elseif ($Export -eq 'JSON') {
				$filepath = Join-Path $ExportPath "incident-$($incident.number).json"
				$incident | ConvertTo-Json | Out-File -FilePath $filepath -Encoding utf8 -Force
				Write-Host "Incident description exported to: $filepath"
				if ($Show.IsPresent) { Invoke-Item $filepath }
			}
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SDIncidents {
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
		[parameter()][int]$PageCount = 0,
		[parameter()][string]$IncidentNameProvision = 'New Users are entered into the IT Authorization Form',
		[parameter()][string]$IncidentNameTermination = 'Employee Terminations'
	)
	try {
		$Session = New-SDSession	
		$baseurl = Get-SDAPI -Name "Search"
		if ([string]::IsNullOrEmpty($baseurl)) { throw "API Url not found." }
		switch ($RequestType) {
			'Provision' {
				$IncName = $IncidentNameProvision
			}
			'Termination' {
				$IncName = $IncidentNameTermination # 'Employee Termination Notification'
			}
		}
		$searchCriteria = "state:`"$($Status)`" AND name:`"$($IncName)`""
		$encodedSearch  = [System.Web.HttpUtility]::UrlEncode($searchCriteria)
		$url = "$($baseurl)?per_page=$PageLimit&q=$($encodedSearch)"
		Write-Verbose "url: $url"
		#$incidents = Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ResponseHeadersVariable responseHeaders -Erroraction Stop
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
		Write-Output $incidents
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Get-SDIncidentLink {
	<#
	.DESCRIPTION
		Generates a unique URL for the specified incident ID and name.
	.PARAMETER Number
		The incident number.
	.PARAMETER Name
		The incident name.
	.EXAMPLE
		Get-SDIncidentLink -Number 149737766 -Name "NH 2/18/25 Abenaa Ampem MBL WKR PKG #1 3000000"
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
function Get-SDRequestProvSingle {
	<#
	.DESCRIPTION
		Retrieves the user provision request table data from the incident record 'description' field.
		This is intended for incidents with a single user provision request.
	.PARAMETER Incident
		The incident record.
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][object]$Incident
	)
	$desc = $Incident.description.Trim()
	if (![string]::IsNullOrWhiteSpace($desc)) {
		$div  = $($desc | ConvertFrom-Html).SelectNodes('//*[@class="grid"]').InnerHtml | ConvertFrom-Html
		$rows = $div.SelectNodes("//tr")
		$rows = $rows[1..$rows.Count]
        $result = @{}
		$rows | ForEach-Object {
			$children = $_.ChildNodes
			$name     = $children[1].InnerText.Trim()
			$value    = $children[5].InnerText.Trim()
            if (![string]::IsNullOrWhiteSpace($name)) {
                $label = Rename-Column -ColumnName $name
			    if ([string]::IsNullOrWhiteSpace($value)) {
				    $x = $($children[5].InnerHtml | Where-Object {$_ -match 'toggled on'})
				    if ($x) {
					    $value = $True
				    }
			    }
                $result[$label] = $value
		        if ($label -eq 'CostCenter') {
			        $costcenter = $value
			        $result['CCNum'] = Compress-CostCenter $value
		        }
            }
		}
    	$result['IncidentNumber'] = $Incident.number
	    $result['Location']       = Get-CostCenterLocation -CostCenter $costcenter
	    $result['Description']    = New-UserDescription -JobTitle $result['JobTitle'] -Location $result['Location']
        [pscustomobject]$result
	}
}

function Get-SDRequestProvSingle2 {
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][object]$Incident
	)
	#######################################
	##### THIS FUNCTION IS DEPRECATED #####
	#######################################
	$incNum      = $Incident.number
	$tableOffset = 13 # 13th table is the request table
	$rowOffset   = 19 # 19th to 56th rows are the request fields
	$rowCount    = 37 # 37 fields in the request table dataset
	$result      = @{}
	$desc        = $Incident.description | ConvertFrom-Html
	$table       = $desc.SelectNodes("//table")[$tableOffset]
	$rows        = $table.SelectNodes("//tr")[$rowOffset..$($rowOffset + $rowCount)]
	Write-Verbose "Iterating through $($rows.Count) columns for incident $incNum."
	foreach ($row in $rows) {
		# retrieve the column name and value
		$cellData = ($row.InnerHtml | ConvertFrom-Html).ChildNodes[0,2].InnerText
		$column   = $cellData[0] # column name
		$value    = $cellData[1] # column value
		$label    = Rename-Column -ColumnName $column # rename column name
		$result[$label] = $value
		if ($label -eq 'CostCenter') {
			$costcenter = $value
			$result['CCNum'] = Compress-CostCenter $value
		}
	}
	Write-Verbose "appending incident number and Location to result."
	$result['IncidentNumber'] = $incNum
	$result['Location']       = Get-CostCenterLocation -CostCenter $costcenter
	$result['Description']    = New-UserDescription -JobTitle $result['JobTitle'] -Location $result['Location']
	[pscustomobject]$result
}

function Get-SDRequestProvBatch {
	<#
	.DESCRIPTION
		Retrieves the user provision request table data from the incident record 'description' field.
		This is intended for incidents with multiple user provision requests in a single table.
	.PARAMETER Incident
		The incident record.
	.EXAMPLE
		Get-SDRequestProvBatch -Incident $incident
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][object]$Incident
	)
	$incNum	      = $Incident.number
	$tableOffset  = 12  # 13th table is the request table
	$columnOffset = 19  # 19th column begins the column headings
	$maxRows      = 100 # assume table has less than 100 rows
	$maxColumns   = 40  # assume table has less than 40 columns
	$desc         = $Incident.description
	$htmlDoc      = ConvertFrom-Html -Content $desc
	$table        = $htmlDoc.SelectNodes("//table")[$tableOffset]
	$columns      = $table.FirstChild.ChildNodes.InnerText # first row is column headings
	$tbody        = $table.LastChild # table body
	$rows         = $tbody.SelectNodes("//tr")[$columnOffset..$maxRows] # retrieve table rows and cells
	$result       = @()
	Write-Verbose "$($rows.Count) requests returned for incident $incNum."
	foreach ($row in $rows) {
		$outrow = @{}
		$added  = $false
		# retrieve the column names and values
		$values = ($row.InnerHtml | ConvertFrom-Html).SelectNodes("//td")[0..$maxColumns] | Select-Object -ExpandProperty InnerText
		# iterate through the columns and values for current row
		for ($i = 0; $i -lt $values.Count; $i++) {
			# retrieve the column name
			$column = $columns[$i]
			if (![string]::IsNullOrEmpty($column)) {
				# rename the column name
				$label  = Rename-Column -ColumnName $column
				$outrow[$label] = $values[$i]
				if ($label -eq 'CostCenter') {
					$outrow['CCNum'] = Compress-CostCenter $values[$i]
				}
				$added = $true
			}
		}
		if ($added) {
			$outrow['IncidentNumber'] = $incNum
		}
		$result += $outrow
	}
	[pscustomobject]$result
}

# Get user termination request table data from incident record (existing, email list)
function Get-SDRequestTermSingle {
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][object]$Incident
	)
	$desc = $Incident.description | ConvertFrom-Html
	$row  = $desc.SelectNodes("//div")[0].SelectNodes("//table")[2].SelectNodes("//tr").SelectNodes("//td")[6].InnerHtml.Trim() -split '<br>'
	$result = @{}
	$row | ForEach-Object {
		$pair  = $_ -split ':'
		$key   = $pair[0].Trim()
		# ignore blank or irrelevant columns
		if ($key -in ('ID','Effective Date','Name')) {
			$value = $pair[1].Trim()
			if ($key -eq 'ID') {
				$label = 'EmployeeID'
   			} elseif ($key -eq 'Effective Date') {
				$label = 'TermDate'
			} else {
				$label = $key
			}
			$result["$label"] = $value
		}
	}
	$result['IncidentNumber'] = $Incident.number
	[pscustomobject]$result
}

function Get-SDRequestTermMultiple {
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][object]$Incident
	)
	$desc    = $Incident.description
	$htmlDoc = ConvertFrom-Html -Content $desc
	$table   = $htmlDoc.SelectNodes("//table")[0]
	$tbody   = $table.LastChild
	$tbody   = $table.LastChild # table body
	$rows    = $tbody.SelectNodes("//tr")[2..100] | Where-Object {$_.InnerLength -gt 200} # retrieve table rows without headings
	$result  = @()
	foreach ($row in $rows) {
		$cellText = $($row.InnerHtml | ConvertFrom-Html).SelectNodes("//td")[0..2].InnerText.Trim()
		$result += [pscustomobject]@{
			DisplayName = $cellText[0].Trim()
			EmployeeID  = $cellText[1].Trim()
			EndDate     = $cellText[2].Trim()
		}
	}
	$result
}

function Export-SDIncidentRequest {
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
		Export-SDIncidentRequest -Number 12345 -SaveToFile
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$Number,
		[parameter()][switch]$SaveToFile,
		[parameter()][string]$OutputPath,
		[parameter()][switch]$Show
	)
	$incident = Get-SDIncident -Number $Number -IncludeDescription -NoRequestData
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

function Update-SDIncident {
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
		Update-SDIncident -Number 12345 -Assignee "jsmith@contoso.org" -Status "Pending Assignment"
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
		$Session = New-SDSession
		Write-Verbose "Requesting Incident $Number"
		$incident = Get-SDIncident -Number $Number -NoRequestData
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
			$user = Get-SDUser -Email $Assignee
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
function Get-SDTask {
	<#
	.DESCRIPTION
		Returns the Service Desk task records for the specified Task URL or Incident Number.
	.PARAMETER TaskURL
		The URL of the task. If provided, returns the specific task record.
	.PARAMETER IncidentNumber
		The incident number. If provided without TaskURL, returns all task records for the specified incident.
	.EXAMPLE
		Get-SDTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
		Returns the task record for the specified Task URL.
	.EXAMPLE
		Get-SDTask -IncidentNumber "12345"
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
		$Session = New-SDSession
		if (![string]::IsNullOrWhiteSpace($TaskURL)) {
			$response = Invoke-RestMethod -Method GET -Uri $TaskURL.Trim() -Headers $Session.headers
		} elseif (![string]::IsNullOrWhiteSpace($IncidentNumber)) {
			$incident = Get-SDIncident -Number $IncidentNumber -NoRequestData
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

function New-SDTask {
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
		New-SDTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com"
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
		$Session  = New-SDSession
		$incident = Get-SDIncident -Number $IncidentNumber
		if (!$incident) { throw "Incident $IncidentNumber not found." }
		$baseurl = Get-SDAPI -Name "Helpdesk Incidents List"
		$url  = "$($baseurl.replace('.json',''))/$($incident.id)/tasks"
		Write-Verbose "Tasks URL: $url"
		Write-Verbose "Verifying User $Assignee"
		$user = Get-SDUser -Email $Assignee
		if (!$user) {
			throw "User $Assignee not found."
		}
		$dueDate = (Get-Date).AddDays($DueDateOffsetDays).ToString("MMM dd, yyyy")
		$task = @{
			name        = $Name.Trim()
			assignee    = @{ email = $Assignee }
			due_at      = $dueDate
			is_complete = $False
		}
		$json = $task | ConvertTo-Json
		#curl -H "X-Samanage-Authorization: Bearer $token" -H "Accept: application/vnd.samanage.v2.1+json" -H "Content-Type: application/json" -X POST $url -d $json
		$response = Invoke-RestMethod -Method POST -Uri $url -ContentType "application/json" -Headers $Session.headers -Body $json -ErrorAction Stop
		$response
	} catch {
		Write-Error $_.Exception.Message
	}
}

function Remove-SDTask {
	<#
	.DESCRIPTION
		Deletes the task for the specified Task URL.
	.PARAMETER TaskURL
		The URL of the task.
	.EXAMPLE
		Remove-SDTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
		Deletes the specified incident task record.
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string][ValidateNotNullOrWhiteSpace()]$TaskURL
	)
	$Session  = New-SDSession
	$response = Invoke-RestMethod -Method DELETE -Uri $TaskURL -Headers $Session.headers
	$response
}
#endregion

#region Users, Roles, Groups
function Get-SDUser {
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
		Get-SDUser -Email "jsmith@contoso.com"
	#>
	[CmdletBinding()]
	param(
		[parameter()][Alias('Name')][string]$Email,
		[parameter()][int]$PageLimit = 100,
		[parameter()][int]$PageCount = 10,
		[parameter()][switch]$NoProgress
	)
	try {
		$Session = New-SDSession
		$baseurl = Get-SDAPI -Name "Users List"
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

function Get-SDRole {
	[CmdletBinding()]
	param(
		[parameter()][string]$Name
	)
	try {
		$Session = New-SDSession
		$baseurl = Get-SDAPI -Name "Roles List"
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

function Get-SDGroup {
	[CmdletBinding()]
	param(
		[parameter()][string]$Name
	)
	try {
		$Session = New-SDSession
		$url     = Get-SDAPI -Name "Groups List"
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

function Get-SDGroupMembers {
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string]$Name
	)
	$group = Get-SDGroup -Name $Name
	$group.memberships
}
#endregion

#region Hardware, Software, Catalog Items
function Get-SDHardware {
	[CmdletBinding()]
	param (
		[parameter()][string]$Id,
		[parameter()][int]$PageCount = 0,
		[parameter()][int]$PageLimit = 100,
		[parameter()][switch]$NoProgress
	)
	try {
		$Session = New-SDSession
		$baseurl = Get-SDAPI -Name "Computers List"
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

function Get-SDCatalogItem {
	[CmdletBinding()]
	param(
		[parameter()][string]$Id,
		[parameter()][string]$Name,
		[parameter()][string]$Tag,
		[parameter()][int]$PageLimit = 100
	)
	try {
		$Session = New-SDSession
		$baseurl = Get-SDAPI -Name "Catalog Items List"
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

function Get-SDCatalogCategories {
	[CmdletBinding()]
	param()
	try {
		$Session = New-SDSession
		$url     = Get-SDAPI -Name "Categories List"
		Write-Verbose "Url: $url"
		Invoke-RestMethod -Uri $url -Headers $Session.headers -Method Get -ErrorAction Stop | Sort-Object name
	} catch {
		Write-Error $_.Exception.Message
	}
}
#endregion

#region Custom Functions
function Rename-Column {
	[CmdletBinding()]
	param (
		[parameter()][string]$ColumnName
	)
	Write-Verbose "Column Name: $ColumnName"
	$headings = @{
		'Latest Comment'                        = 'LatestComment'
		'Network Start Date'                    = 'StartDate'
		'Covid Test Date'                       = 'CovidTestDate'
		'Email Setup'                           = 'EmailSetup'
		'Pronouns'                              = 'Pronouns'
		'New CBHC Staff'                        = 'CBHCStaff'
		'Network End Date (Estimate if needed)' = 'EndDate'
		'First Name'                            = 'FirstName'
		'Last Name'                             = 'LastName'
		'Rehire'                                = 'Rehire'
		'Current/Recent Intern'                 = 'RecentIntern'
		'Employee ID'                           = 'EmployeeID'
		'Cost Center'                           = 'CostCenter'
		'Job Title'                             = 'JobTitle'
		'Equipment Needed'                      = 'EquipmentNeeded'
		'Supervisor'                            = 'Supervisor'
		'Degree'                                = 'Degree'
		'NPI Number'                            = 'NPINumber'
		'Supervisor approval'                   = 'SupervisorApproval'
		'License'                               = 'License'
		'License Number'                        = 'LicenseNumber'
		'License Type'                          = 'LicenseType'
		'License Expiration Date'               = 'LicenseExpirationDate'
		'Relief Staff'                          = 'ReliefStaff'
		'Intern'                                = 'IsIntern'
		'Manager'                               = 'Manager'
		'HD Completed'                          = 'HDCompleted'
		'Application Setup Completed'           = 'AppCompleted'
		'Temp'                                  = 'IsTemp'
		'Consultant'                            = 'IsConsultant'
		'Consultant Email Needed'               = 'EmailNeeded'
		'Business Unit'                         = 'BusinessUnit'
		'A&amp;F'                               = 'AandF'
		'Day Supports &amp; Other'              = 'DaySupports'
		'DS/BI'                                 = 'DSBI'
		'BH'                                    = 'BH'
		'BH Res'                                = 'BHRes'
		'Comments'                              = 'Comments'
	}
	if ($headings.ContainsKey($ColumnName)) {
		Write-Output $headings[$ColumnName]
	} else {
		Write-Output $ColumnName
	}
}

function Compress-CostCenter {
	<#
	.DESCRIPTION
		Removes the dashes from the cost center number prefix portion a Cost Center string input.
	.EXAMPLE
		Compress-CostCenter -CostCenter "1-234-56-7 - 100 Main Street"
		Returns: "1234567"
	#>
	param (
		[parameter()][string]$CostCenter
	)
	if (![string]::IsNullOrWhiteSpace($CostCenter)) {
		$CostCenter.Substring(0,10) -replace '-',''
	} else {
		""
	}
}

function Get-CostCenterLocation {
	<#
	.DESCRIPTION
		Returns the location portion of the cost center after the number prefix portion.
	.EXAMPLE
		Get-CostCenterLocation -CostCenter "1-234-56-7 - 100 Main Street"
		Returns: "100 Main Street"
	#>
	[CmdletBinding()]
	param(
		[parameter()][string]$CostCenter
	)
	if (![string]::IsNullOrWhiteSpace($CostCenter)) {
		Write-Verbose "CostCenter input: $CostCenter"
		if ($CostCenter.Length -gt 12) {
			$CostCenter.Substring(12).Trim()
		} else {
			""
		}
	} else {
		""
	}
}

function New-UserDescription {
	<#
	.DESCRIPTION
		Generates a user description string based on the job title and location.
	.PARAMETER JobTitle
		The user's job title.
	.PARAMETER Location
		The user's location.
	.EXAMPLE
		New-UserDescription -JobTitle "IT Specialist" -Location "100 Main Street"
		Returns: "IT Specialist at 100 Main Street"
	#>
	param (
		[parameter()][string]$JobTitle,
		[parameter()][string]$Location
	)
	if (![string]::IsNullOrWhiteSpace($JobTitle) -and ![string]::IsNullOrWhiteSpace($Location)) {
		"$($JobTitle.Trim()) at $($Location.Trim())"
	} elseif (![string]::IsNullOrWhiteSpace($JobTitle)) {
		$JobTitle.Trim()
	} elseif (![string]::IsNullOrWhiteSpace($Location)) {
		$Location.Trim()
	} else {
		""
	}
}
#endregion