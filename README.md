# SolarWinds.ServiceDesk

PowerShell Abstraction Layer for SolarWinds Service Desk REST API

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue) ![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20MacOS-lightgrey) ![License](https://img.shields.io/badge/license-MIT-green)

A comprehensive PowerShell module providing an abstraction layer for the SolarWinds Service Desk (SwSD) REST API. This module simplifies interaction with Service Desk through PowerShell cmdlets, focusing primarily on incident (ticket) management. Just because I could, not that I should.

## 🎯 Overview

This module is built to streamline SolarWinds Service Desk operations through PowerShell automation. It was created for my own needs, but further development will be based upon general interest and feedback. If you find something that needs fixing, improving, or adding, drop a new [Issue](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/issues) here. Thank you!

## ✨ Features

- 🎫 **Incident Management** - Create, update, query, and export Service Desk incidents
- 📋 **Task Management** - Create, update, and remove tasks associated with incidents
- 💬 **Comments & Audit Logs** - Add comments to tickets and query audit logs
- 👥 **User & Group Management** - Query users, groups, and group memberships
- 🏢 **Organization Data** - Access departments, sites, vendors, and roles
- 💻 **Asset Management** - Query hardware, mobile devices, printers, and other assets
- 📦 **Service Catalog** - Browse catalog categories and items
- 🔗 **Incident Links** - Manage relationships between incidents
- 🛠️ **Purchase Orders** - Query purchase order information
- 🐛 **Problem Management** - Access problem records

## Requirements

- PowerShell 5.1 or higher (tested primarily on 7.5.1)
- Windows, Linux, or MacOS
- Active SolarWinds Service Desk subscription
- Valid API token for authentication

## Installation

### From PowerShell Gallery (Recommended)

```powershell
Install-Module -Name SolarWinds.ServiceDesk -Scope CurrentUser
```

### From GitHub

1. Clone the repository

```powershell
git clone https://github.com/Skatterbrainz/SolarWinds.ServiceDesk.git
cd SolarWinds.ServiceDesk
```

2. Import the module

```powershell
Import-Module ./SolarWinds.ServiceDesk.psd1
```

## Usage

Import the module and explore available cmdlets:

```powershell
# Import the module
Import-Module SolarWinds.ServiceDesk

# Get all available cmdlets
Get-Command -Module SolarWinds.ServiceDesk

# Get help for a specific cmdlet
Get-Help Connect-SwSd -Full

# Connect to Service Desk
Connect-SwSd -ApiToken "<YOUR TOKEN>"
```

### Examples

**Connect to Service Desk using an explicit Token string**

```powershell
Connect-SwSd -ApiToken "<YOUR TOKEN>"
```

**Connect to Service Desk using an existing $env:SWSDToken variable**

```powershell
Connect-SwSd
```

**Return a list of incidents by status and name**

```powershell
$incidents = Get-SwSdIncident -Status "Pending Assignment" -Name "Request for New User Account"
```

**Return information for a single incident**

```powershell
$incident = Get-SwSdIncident -Number 12345
```

**Update an incident to assign to a user**

```powershell
Update-SwSdIncident -Number 12345 -Status "Assigned" -Assignee "jsmith@contoso.com"
```

**Update an incident status to Closed**

```powershell
Update-SwSdIncident -Number 12345 -Status "Closed"
```

**Get Tasks related to an incident**

```powershell
Get-SwSdTask -IncidentNumber 12345
```

**Add a new Task to an incident**

```powershell
New-SwSdTask -IncidentNumber 12345 -Name "Assign Laptop" -Assignee "bjones@contoso.com" -DueDateOffsetDays 7
```

**Update a Task on an incident to set status to Completed**

```powershell
$task = Get-SwSdTask -IncidentNumber 12345 | Where-Object name -eq 'Assign Laptop'
Update-SwSdTask -TaskURL $task.href -Assignee "ctaylor@contoso.com" -Completed
```

## 📖 Documentation

Full documentation for each cmdlet is available in the [docs](./docs) directory:

- [Connect-SwSd](./docs/Connect-SwSD.md) - Authenticate to Service Desk API
- [Get-SwSdIncident](./docs/Get-SwSdIncident.md) - Query incident records
- [New-SwSdIncident](./docs/New-SwSdIncident.md) - Create new incidents
- [Update-SwSdIncident](./docs/Update-SwSdIncident.md) - Update existing incidents
- [Get-SwSdTask](./docs/Get-SwSdTask.md) - Query tasks on incidents
- [New-SwSdTask](./docs/New-SwSdTask.md) - Create new tasks
- And [many more](./docs)...

## Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features or cmdlets
- Add support for additional Service Desk APIs
- Improve documentation
- Submit pull requests

Please open an [issue](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/issues) or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Author

Skatterbrainz

- GitHub: [@Skatterbrainz](https://github.com/Skatterbrainz)

## Acknowledgments

- Built for PowerShell 5.1+ on Windows, Linux, and MacOS
- Inspired by the need to automate SolarWinds Service Desk operations
- Thanks to all contributors and users who have provided feedback and suggestions

## 📋 Version History

### 1.0.6 - 2/11/2026

- Added: Add-SwSdGroupMember
- Updated: Get-SwSdAPI - Added Force parameter to refresh API list cache; Implemented caching mechanism using $global:SDAPIList to minimize API calls; Added Search API manually to the list (not included in API response)
- Updated: Get-SwSdIncident - Added PageLimit parameter (1-500 range, default 100) to control records per page; Added PageCount parameter (0-100 range, default 0 for all pages) to limit number of pages returned; Enhanced pagination support for large result sets
- Updated: Get-SwSdTask - Improved error handling for task retrieval; Enhanced verbose logging for task operations
- Updated: Get-SwSdGroup - Added Id parameter to search by group ID; Enhanced filtering to support both Name and ID parameters

### 1.0.5 - 2/10/2026

- Fixed: New-SwSdIncident - Fixed bug with SDSession headers and default input parameters
- Fixed: Update-SwSdIncident - Fixed bug with SDSession headers and default input parameters
- Fixed: New-SwSdTask - Fixed bug with SDSession headers

### 1.0.4 - 12/10/2025

- Updated: Get-SwSdIncident, Get-SwSdPurchaseOrder, Get-SwSdUser, (getAPIResponse, getAPIResponseByURL) - Added -UseBasicParsing to address [CVE-2025-54100](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2025-54100)

### 1.0.3 - 6/22/2025

- Updated: All functions - Added outputtype() and aliases
- Updated: Get-SwSdIncident - Added input parameter validation refinements

### 1.0.2 - 5/2/2025

- Added: Get-SwSdAuditLog, Get-SwSdDepartment, Get-SwSdMobileDevice, Get-SwSdOtherAsset, Get-SwSdPrinter, Get-SwSdProblems, Get-SwSdPurchaseOrder, Get-SwSdSite, Get-SwSdVendor
- Updated: New-SwSDTask - Revised DueDateOffsetDays to DueDate and made the default null
- Updated: Update-SwSDTask - Updated help documentation

### 1.0.1 - 4/16/2025

- Fixed: Get-SwSdTask - Fixed bug in parameter reference and corrected the response JSON data
- Updated: New-SwSdTask - Changed DueDateOffsetDays default from 14 to 7 days
- Updated: Update-SwSdTask - Added support for DueDate property
- Note: Still wondering why the Reminder property isn't exposed through the REST API

### 1.0.0 - 4/12/2025

- Created: It was born. Cigars were smoked. Insurance was billed.
