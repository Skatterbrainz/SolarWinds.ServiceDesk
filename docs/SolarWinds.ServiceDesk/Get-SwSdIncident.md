---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdIncident.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdIncident
---

# Get-SwSdIncident

## SYNOPSIS

Returns a Service Desk incident or list of incidents.

## SYNTAX

### __AllParameterSets

```
Get-SwSdIncident [[-Number] <string>] [[-Id] <int>] [[-Name] <string>] [[-Status] <string>]
 [[-PageLimit] <int>] [[-PageCount] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns a Service Desk incident for the specified incident Number or ID + name.
If Number and Id are not provided, it returns a list of incidents.
When requesting a list of incidents, the status and name can be used to filter the results.
By default, it returns 100 records per page.
The maximum number of pages is 0 (all pages).

## EXAMPLES

### EXAMPLE 1

Get-SwSdIncident -Number 12345
Returns the incident record for incident number 12345.

### EXAMPLE 2

Get-SwSdIncident -Id 123456789 -Name "Incident Name"
Returns the incident record for incident ID 12345 with the specified name.

### EXAMPLE 3

Get-SwSdIncident -Status "Pending Assignment" -Name "Incident Name"
Returns a list of incidents with status "Pending Assignment" and name "Incident Name".

### EXAMPLE 4

Get-SwSdIncident -Status "Pending Assignment" -PageLimit 50 -PageCount 2
Returns a list of incidents with status "Pending Assignment", with a maximum of 50 records per page, and returns 2 pages.

## PARAMETERS

### -Id

The incident ID.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -Name

The incident name.
Required if Id is provided.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
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
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PageCount

The number of pages to return.
Default is 0 (all pages).
Valid values are between 0 and 100.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PageLimit

The maximum number of records to return per page.
Default is 100.
Valid values are between 1 and 500.
If PageLimit is set to 0, it returns all records.

```yaml
Type: System.Int32
DefaultValue: 100
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Status

The status of the incident, for example "Pending Assignment", "Assigned", "Closed", etc.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
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

Reference: https://apidoc.samanage.com/#tag/Incident


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdIncident.md)
