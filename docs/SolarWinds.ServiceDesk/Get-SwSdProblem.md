---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdProblem.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdProblem
---

# Get-SwSdProblem

## SYNOPSIS

Returns the Service Desk problem records for the specified criteria or all problems.

## SYNTAX

### __AllParameterSets

```
Get-SwSdProblem [[-Name] <string>] [[-Id] <string>] [[-Status] <string>] [[-Priority] <string>]
 [[-HREF] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the Service Desk problem records for the specified criteria or all problems.

## EXAMPLES

### EXAMPLE 1

Get-SwSdProblem -Name "Network Issue"

Returns the problem record for the specified name.

### EXAMPLE 2

Get-SwSdProblem -Id "12345"

Returns the problem record for the specified ID.

### EXAMPLE 3

Get-SwSdProblem -Status "Open"

Returns the problem records for the specified status.

### EXAMPLE 4

Get-SwSdProblem -Priority "High"

Returns the problem records for the specified priority.

### EXAMPLE 5

Get-SwSdProblem -HREF "https://api.samanage.com/problem/1234567890"

Returns the problem record for the specified HREF.

### EXAMPLE 6

Get-SwSdProblem

Returns all problem records.

## PARAMETERS

### -HREF

The problem HREF.
If provided, returns the specific problem record.

```yaml
Type: System.String
DefaultValue: ''
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

### -Id

The problem ID.
If provided, returns the specific problem record.

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

The problem name or ID.
If provided, returns the specific problem record.

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

### -Priority

The problem priority.
If provided, returns the specific problem record.

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

### -Status

The problem status.
If provided, returns the specific problem record.

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

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdProblem.md)
