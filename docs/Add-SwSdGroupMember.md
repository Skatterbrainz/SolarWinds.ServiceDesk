---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Add-SwSdGroupMember.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Add-SwSdGroupMember
---

# Add-SwSdGroupMember

## SYNOPSIS

Adds a user to a specified group in SolarWinds Service Desk.

## SYNTAX

### __AllParameterSets

```
Add-SwSdGroupMember [-GroupName] <string> [-UserEmail] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Adds a user to a specified group in SolarWinds Service Desk by making an API call to the appropriate endpoint.

## EXAMPLES

### EXAMPLE 1

Add-SwSdGroupMember -GroupName "Admins" -UserEmail "user1@example.com"

Adds the user with email

### EXAMPLE 2

Add-SwSdGroupMember -GroupName "Admins" -UserEmail "user1@example.com,user2@example.com"

Adds the users with email addresses

## PARAMETERS

### -GroupName

The name of the group to which the user will be added.

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

### -UserEmail

The email address of the user to be added to the group.
The user must already exist in the Service Desk system.
Multiple names or email addresses can be specified by separating them with commas.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
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

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Add-SwSdGroupMember.md)
