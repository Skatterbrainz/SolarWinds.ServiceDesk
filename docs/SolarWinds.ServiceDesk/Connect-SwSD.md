---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Connect-SwSD.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Connect-SwSD
---

# Connect-SwSD

## SYNOPSIS

Creates a new SolarWinds Service Desk session.

## SYNTAX

### __AllParameterSets

```
Connect-SwSD [[-ApiToken] <string>] [[-ApiUrl] <string>] [[-ApiVersion] <string>]
 [[-ApiFormat] <string>] [-Refresh] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Creates a new SolarWinds Service Desk session.
If a session already exists, it will return the existing session unless the `-Refresh` switch is used.
You can provide the API token, URL, version, and format as parameters.
If the API token is not provided, it will look for the `$env:SWSDToken` environment variable.
You can also set the API URL, version, and format as parameters.
The default values are:
	- ApiUrl: "https://api.samanage.com"
	- ApiVersion: "v2.1"
	- ApiFormat: "json"

## EXAMPLES

### EXAMPLE 1

Connect-SwSD -ApiToken "your_api_token"

Creates a new SolarWinds Service Desk session with the specified API token.

### EXAMPLE 2

Connect-SwSD -ApiUrl "https://api.samanage.com" -ApiVersion "v2.1" -ApiFormat "json"

Creates a new SolarWinds Service Desk session with the specified API URL, version, and format.

### EXAMPLE 3

Connect-SwSD -Refresh

Refreshes the existing SolarWinds Service Desk session.

## PARAMETERS

### -ApiFormat

The API format: json or xml.
Default is "json".

```yaml
Type: System.String
DefaultValue: json
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

### -ApiToken

The authentication API token.
This is required if not set in the environment variable `$env:SWSDToken`.

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

### -ApiUrl

The API URL.
Default is "https://api.samanage.com".

```yaml
Type: System.String
DefaultValue: https://api.samanage.com
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

### -ApiVersion

The API version.
Default is "v2.1".

```yaml
Type: System.String
DefaultValue: v2.1
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

### -Refresh

Refresh the session.

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

### System.Management.Automation.PSObject

{{ Fill in the Description }}

## NOTES

Reference: https://apidoc.samanage.com/#section/General-Concepts/Service-URL


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Connect-SwSD.md)
