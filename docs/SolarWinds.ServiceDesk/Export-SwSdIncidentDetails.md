---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Export-SwSdIncidentDetails.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Export-SwSdIncidentDetails
---

# Export-SwSdIncidentDetails

## SYNOPSIS

Exports the incident details information to a file.

## SYNTAX

### __AllParameterSets

```
Export-SwSdIncidentDetails [-Number] <string> [[-OutputPath] <string>] [-SaveToFile] [-Show]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Exports the incident details (description property) information to a file.

## EXAMPLES

### EXAMPLE 1

Export-SwSdIncidentDetails -Number 12345 -SaveToFile

Exports the incident details for incident number 12345 to a file.

### EXAMPLE 2

Export-SwSdIncidentDetails -Number 12345 -SaveToFile -OutputPath "C:\Temp"

Exports the incident details for incident number 12345 to a file in the specified path.

### EXAMPLE 3

Export-SwSdIncidentDetails -Number 12345 -Show

Exports the incident details for incident number 12345 and displays it in the default web browser.

## PARAMETERS

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

### -OutputPath

The path to save the file.
Default is the user's Documents folder.

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

### -SaveToFile

Save the request data to a file.

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

### -Show

Display the exported HTML request data in the default web browser.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Reference: https://apidoc.samanage.com/#tag/Incident


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Export-SwSdIncidentDetails.md)
