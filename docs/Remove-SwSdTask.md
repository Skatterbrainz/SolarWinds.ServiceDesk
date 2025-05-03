---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Remove-SwSdTask.md
schema: 2.0.0
---

# Remove-SwSdTask

## SYNOPSIS
Deletes the task for the specified Task URL.

## SYNTAX

```
Remove-SwSdTask [-TaskURL] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Deletes the task for the specified Task URL.

## EXAMPLES

### EXAMPLE 1
```
Remove-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
```

Deletes the specified incident task record.

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
Reference: https://apidoc.samanage.com/#tag/Task

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Remove-SwSdTask.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Remove-SwSdTask.md)

