---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Update-SwSDTask

## SYNOPSIS

## SYNTAX

```
Update-SwSDTask [-TaskURL] <String> [[-Assignee] <String>] [-Completed] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the specified task record with the provided assignee and/or status.

## EXAMPLES

### EXAMPLE 1
```
Update-SwSDTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json" -Completed
```

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

## RELATED LINKS
