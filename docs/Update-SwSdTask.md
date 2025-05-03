---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdTask.md
schema: 2.0.0
---

# Update-SwSdTask

## SYNOPSIS
Updates the specified task record with the provided assignee and/or status.

## SYNTAX

```
Update-SwSdTask [-TaskURL] <String> [[-Assignee] <String>] [[-DueDate] <DateTime>] [-Completed]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Updates the specified task record with the provided assignee and/or status.
You can specify either the assignee or status, or both.
Assignee must be a valid SWSD user account.

## EXAMPLES

### EXAMPLE 1
```
Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Completed
```

Updates the task record for the specified Task URL and marks it as completed.

### EXAMPLE 2
```
Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Assignee "jsmith@contoso.com"
```

Updates the task record for the specified Task URL and assigns it to the specified user.

### EXAMPLE 3
```
Update-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -DueDate (Get-Date).AddDays(7)
```

Updates the task record for the specified Task URL and sets the due date to 7 days from now.

## PARAMETERS

### -TaskURL
The URL of the task.

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

### -Assignee
The email address of the assignee.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Email

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DueDate
The due date for the task.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Completed
Mark the task as completed.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
The Assignee must be a valid SWSD user account.

Reference: https://apidoc.samanage.com/#tag/Task

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdTask.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Update-SwSdTask.md)

