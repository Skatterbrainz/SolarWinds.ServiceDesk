---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdHardware.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdHardware
---

# Get-SwSdHardware

## SYNOPSIS

Returns the hardware records for the specified ID or all hardware.

## SYNTAX

### __AllParameterSets

```
Get-SwSdHardware [[-Id] <string>] [[-PageCount] <int>] [[-PageLimit] <int>] [-NoProgress]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the hardware records for the specified ID or all hardware.

## EXAMPLES

### EXAMPLE 1

Get-SwSdHardware -Id 12345

Returns the hardware record for the specified ID.

### EXAMPLE 2

Get-SwSdHardware -PageCount 5

Returns the first 5 pages of hardware records.

### EXAMPLE 3

Get-SwSdHardware -PageLimit 50

Returns a list of hardware records with a maximum of 50 records per page.

### EXAMPLE 4

Get-SwSdHardware -NoProgress

Returns a list of hardware records without showing the progress indicator.

## PARAMETERS

### -Id

The hardware ID.

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

### -NoProgress

Suppress the progress indicator.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
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

### -PageLimit

The maximum number of records to return per page.
Default is 100.

```yaml
Type: System.Int32
DefaultValue: 100
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

Reference: https://apidoc.samanage.com/#tag/Hardware


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdHardware.md)
