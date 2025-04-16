---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdTask.md
schema: 2.0.0
---

# New-SwSdTask

## SYNOPSIS
Creates a new task for the specified incident number.

## SYNTAX

```
New-SwSdTask [-IncidentNumber] <String> [-Name] <String> [-Assignee] <String> [[-IsComplete] <Boolean>]
 [[-DueDateOffsetDays] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new task for the specified incident number. 
The task is assigned to the specified user and has a due date offset by the specified number of days.

## EXAMPLES

### EXAMPLE 1
```
New-SwSdTask -IncidentNumber "12345" -Name "Task Name" -Assignee "user123@contoso.com"
```

## PARAMETERS

### -IncidentNumber
The incident number.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The task name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Assignee
The task assignee email address.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsComplete
The task completion status.
Default is False.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DueDateOffsetDays
The number of days to offset the due date.
Default is 14 days.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 7
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Refer to https://apidoc.samanage.com/#tag/Task/operation/createTask

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdTask.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdTask.md)

