---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPrinter.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdPrinter
---

# Get-SwSdPrinter

## SYNOPSIS

Returns the Service Desk printer records for the specified ID or all printers.

## SYNTAX

### __AllParameterSets

```
Get-SwSdPrinter [[-Name] <string>] [[-Id] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the Service Desk printer records for the specified ID or all printers.

## EXAMPLES

### EXAMPLE 1

Get-SwSdPrinter -Name "Printer1"

Returns the printer record for the specified name.

### EXAMPLE 2

Get-SwSdPrinter -Id "12345"

Returns the printer record for the specified ID.

### EXAMPLE 3

Get-SwSdPrinter

Returns all printer records.

## PARAMETERS

### -Id

The printer ID.
If provided, returns the specific printer record.

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

### -Name

The printer name.
If provided, returns the specific printer record.

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

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPrinter.md)
