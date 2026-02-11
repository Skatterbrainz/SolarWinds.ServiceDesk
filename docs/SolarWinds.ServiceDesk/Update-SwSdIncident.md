---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdIncident.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Update-SwSdIncident
---

# Update-SwSdIncident

## SYNOPSIS

Updates the specified incident record with the provided assignee and/or status.

## SYNTAX

### __AllParameterSets

```
Update-SwSdIncident [-Number] <string> [[-Assignee] <string>] [[-Status] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Updates the specified incident record with the provided assignee and/or status.
You can specify either the assignee or status, or both.
Assignee must be a valid SWSD user account.

## EXAMPLES

### EXAMPLE 1

Update-SwSdIncident -Number 12345 -Assignee "jsmith@contoso.org" -Status "Pending Assignment"

Updates the incident 12345 with the specified assignee 'jsmith@contoso.org' and status 'Pending Assignment'.

### EXAMPLE 2

Update-SwSdIncident -Number 12345 -Status "Closed"

Updates the incident 12345 with the specified status 'Closed'

## PARAMETERS

### -Assignee

The email address of the assignee.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Email
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Number

The incident number.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Status

The status of the incident: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled.
The default status is 'Assigned'.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- State
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject

{{ Fill in the Description }}

## NOTES

The Assignee must be a valid SWSD user account.
Reference: https://apidoc.samanage.com/#tag/Incident


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdIncident.md)
