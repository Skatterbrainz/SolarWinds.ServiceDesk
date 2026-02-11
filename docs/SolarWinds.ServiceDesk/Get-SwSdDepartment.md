---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdDepartment.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdDepartment
---

# Get-SwSdDepartment

## SYNOPSIS

Returns the Service Desk department records for the specified ID or all departments.

## SYNTAX

### __AllParameterSets

```
Get-SwSdDepartment [[-Name] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the Service Desk department records for the specified ID or all departments.

## EXAMPLES

### EXAMPLE 1

Get-SwSdDepartment -Name "IT"

Returns the department record for the specified name.

### EXAMPLE 2

Get-SwSdDepartment -Name "12345"

Returns the department record for the specified ID.

### EXAMPLE 3

Get-SwSdDepartment

Returns all department records.

## PARAMETERS

### -Name

The department name or ID.
If provided, returns the specific department record.

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

## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdDepartment.md)
