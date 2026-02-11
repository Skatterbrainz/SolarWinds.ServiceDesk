---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAPI.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdAPI
---

# Get-SwSdAPI

## SYNOPSIS

Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.

## SYNTAX

### __AllParameterSets

```
Get-SwSdAPI [[-Name] <string>] [-Force] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.
Caches list to global variable $SDAPIList, to minimize API calls.

## EXAMPLES

### EXAMPLE 1

Get-SwSdAPI -Name "Incidents List"
Returns the URL for the Incidents List API

### EXAMPLE 2

Get-SwSdAPI
Returns all API URLs

### EXAMPLE 3

Get-SwSdAPI -Name "Search"
Returns the URL for the Search API

### EXAMPLE 4

Get-SwSdAPI -Name "Search" -Force
Returns the URL for the Search API, forcing refresh of the API list from the API, instead of using cached list.

## PARAMETERS

### -Force

Force refresh of the API list from the API, instead of using cached list.

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

### -Name

The name of the API to retrieve.
If not specified, returns the list of available APIs.

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

### System.String

{{ Fill in the Description }}

### System.Management.Automation.PSObject

{{ Fill in the Description }}

## NOTES

Reference: https://apidoc.samanage.com/#section/General-Concepts/API-Entry-Point


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAPI.md)
