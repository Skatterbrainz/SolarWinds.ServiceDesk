---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdUser
---

# Get-SwSdUser

## SYNOPSIS

Returns the Service Desk user records for the specified email or ID.

## SYNTAX

### __AllParameterSets

```
Get-SwSdUser [[-Email] <string>] [[-Id] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns Service Desk user records for the specified email address or ID.
If no email or ID is specified, returns all users.

## EXAMPLES

### EXAMPLE 1

Get-SwSdUser -Email "jsmith@contoso.com"

Returns the user record for the specified email address.

### EXAMPLE 2

Get-SwSdUser -Id 12345

Returns the user record for the specified ID.

## PARAMETERS

### -Email

The user's email address.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Name
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

### -Id

The user ID. If provided, returns the specific user record.

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

Reference: https://apidoc.samanage.com/#tag/User


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md)
