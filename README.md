# SolarWinds.ServiceDesk

This module provides an abstraction layer for the SolarWinds Service Desk (SwSD) REST API, focused mainly on incidents (tickets). This module was built for my own needs, but further development will be based upon that and general public interest (volume of downloads) or feedback (see below).

Please submit feature enhancements or bug fixes by creating an [Issue](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/issues).

# Requirements

* PowerShell 5.1 or newer
* Windows, Linux, MacOS
* An active Service Desk subscription and API token

# Examples

## Connect to Service Desk: Using an explicit Token string.

```powershell
Connect-SwSd -ApiToken "<YOUR TOKEN>"
```

## Connect to Service Desk: Using an existing $env:SWSDToken variable.

```powershell
Connect-SwSd
```

## Getting Incidents

Return a list of incidents by status and name.

```powershell
$incidents = Get-SwSdIncident -Status "Pending Assignment" -Name "Request for New User Account"
```

Return information for a single incident.

```powershell
$incident = Get-SwSdIncident -Number 12345
```

Update an incident to assign to a user.

```powershell
Update-SwSdIncident -Number 12345 -Status "Assigned" -Assignee "jsmith@contoso.com"
```

Update an incident to set the status to Closed.

```powershell
Update-SwSdIncident -Number 12345 -Status "Closed"
```

Get Tasks related to an incident.

```powershell
Get-SwSdTask -IncidentNumber 12345
```

Add a new Task to an incident.

```powershell
New-SwSdTask -IncidentNumber 12345 -Name "Assign Laptop" -Assignee "bjones@contoso.com" -DueDateOffsetDays 7
```

Update a Task on an incident to set status to Completed.

```powershell
$task = Get-SwSdTask -IncidentNumber 12345 | Where-Object name -eq 'Assign Laptop'
Update-SwSdTask -TaskURL $task.href -Assignee "ctaylor@contoso.com" -Completed
```

# Want more? 

Head over to the [Issues](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/issues) page to send feedback. Thank you!

# Revision History

- 1.0.2 - 4/23/2025
  - New-SDTask - Revised DueDateOffsetDays to DueDate and made the default null (nil)
  - Update-SDTask - Updated help documentation
- 1.0.1 - 4/16/2025
  - Get-SwSdTask - Fixed bug in parameter reference and corrected the response JSON data
  - New-SwSdTask - Changed DueDateOffsetDays default from 14 to 7 days
  - Update-SwSdTask - Added support for DueDate property
  - Tasks API: Still wondering why the Reminder property isn't exposed through the REST API
- 1.0.0 - 4/12/2025
  - It was born. Cigars were smoked. Insurance was billed.
