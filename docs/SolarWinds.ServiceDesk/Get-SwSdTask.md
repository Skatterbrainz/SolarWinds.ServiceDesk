---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdTask.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdTask
---

# Get-SwSdTask

## SYNOPSIS

Returns the Service Desk task records for the specified Task URL or Incident Number.

## SYNTAX

### __AllParameterSets

```
Get-SwSdTask [[-TaskURL] <string>] [[-IncidentNumber] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the Service Desk task records for the specified Task URL or Incident Number.

## EXAMPLES

### EXAMPLE 1

Get-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"

Returns the task record for the specified Task URL.

### EXAMPLE 2

Get-SwSdTask -IncidentNumber "12345"

Returns the task records for the Incident record having the number 12345.

## PARAMETERS

### -IncidentNumber

The incident number.
If provided without TaskURL, returns all task records for the specified incident.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
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

### -TaskURL

The URL of the task.
If provided, returns the specific task record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
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

If both TaskURL and IncidentNumber are provided, TaskURL takes precedence.

Returns an error if neither TaskURL nor IncidentNumber is provided.


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdTask.md)
