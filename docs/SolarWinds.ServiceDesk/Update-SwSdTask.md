---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdTask.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Update-SwSdTask
---

# Update-SwSdTask

## SYNOPSIS

Updates the specified task record with the provided assignee and/or status.

## SYNTAX

### __AllParameterSets

```
Update-SwSdTask [-TaskURL] <string> [[-Assignee] <string>] [[-DueDate] <datetime>] [-Completed]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Updates the specified task record with the provided assignee and/or status.
You can specify either the assignee or status, or both.
Assignee must be a valid SWSD user account.

## EXAMPLES

### EXAMPLE 1

Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Completed

Updates the task record for the specified Task URL and marks it as completed.

### EXAMPLE 2

Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Assignee "jsmith@contoso.com"

Updates the task record for the specified Task URL and assigns it to the specified user.

### EXAMPLE 3

Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -DueDate (Get-Date).AddDays(7)

Updates the task record for the specified Task URL and sets the due date to 7 days from now.

## PARAMETERS

### -Assignee

The email address of the assignee.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- Email
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

### -Completed

Mark the task as completed.

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

### -DueDate

The due date for the task.

```yaml
Type: System.DateTime
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

### -TaskURL

The URL of the task.

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

The Assignee must be a valid SWSD user account.

Reference: https://apidoc.samanage.com/#tag/Task


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdTask.md)
