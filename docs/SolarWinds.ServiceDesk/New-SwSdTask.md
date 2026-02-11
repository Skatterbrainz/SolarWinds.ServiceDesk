---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdTask.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: New-SwSdTask
---

# New-SwSdTask

## SYNOPSIS

Creates a new task for the specified incident number.

## SYNTAX

### __AllParameterSets

```
New-SwSdTask [-IncidentNumber] <string> [-Name] <string> [-Assignee] <string> [[-IsComplete] <bool>]
 [[-DueDate] <datetime>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Creates a new task for the specified incident number.

The task is assigned to the specified user and can have a due date and completion status.
Use the -IsComplete parameter to set the task as complete.

## EXAMPLES

### EXAMPLE 1

New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com"

Add a task for "Task Name" assigned to user "user123@contoso.com" with no due date.

### EXAMPLE 2

New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com" -DueDate "2025-12-31"

Add a task for "Task Name" assigned to user "user123@contoso.com" with a due date of "2025-12-31".

### EXAMPLE 3

New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com" -IsComplete $True

Add a task for "Task Name" assigned to user "user123@contoso.com" with a completion status of $True.

## PARAMETERS

### -Assignee

The task assignee email address.
Must be a valid Service Desk user or group.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DueDate

The due date for the task.
Default is no due date.

```yaml
Type: System.DateTime
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

### -IncidentNumber

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

### -IsComplete

The task completion status.
True indicates a completed task.
The default is False.

```yaml
Type: System.Boolean
DefaultValue: False
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

### -Name

The task name or description.

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

Refer to https://apidoc.samanage.com/#tag/Task/operation/createTask


## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdTask.md)
