# SolarWinds.ServiceDesk

This module provides an abstraction layer for the SolarWinds Service Desk (SwSD) REST API, focused mainly on incidents (tickets). This module was built for my own needs, but further development will be based upon that and general public interest (volume of downloads) or feedback (see below).

Please submit feature enhancements or bug fixes by creating an [Issue](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/issues).

# Connecting to Service Desk

## Connect with an explicit Token string.

```powershell
Connect-SwSd -ApiToken "<YOUR TOKEN>"
```

## Connect with an existing $env:SWSDToken variable.

```powershell
Connect-SwSd
```

# Getting Incidents

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