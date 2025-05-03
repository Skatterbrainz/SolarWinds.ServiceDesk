---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdTask.md
schema: 2.0.0
---

# Get-SwSdTask

## SYNOPSIS
Returns the Service Desk task records for the specified Task URL or Incident Number.

## SYNTAX

```
Get-SwSdTask [[-TaskURL] <String>] [[-IncidentNumber] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk task records for the specified Task URL or Incident Number.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdTask -TaskURL "https://api.samanage.com/incidents/123456789/tasks/98765432.json"
```

Returns the task record for the specified Task URL.

### EXAMPLE 2
```
Get-SwSdTask -IncidentNumber "12345"
```

Returns the task records for the Incident record having the number 12345.

## PARAMETERS

### -TaskURL
The URL of the task.
If provided, returns the specific task record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncidentNumber
The incident number.
If provided without TaskURL, returns all task records for the specified incident.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
If both TaskURL and IncidentNumber are provided, TaskURL takes precedence.

Returns an error if neither TaskURL nor IncidentNumber is provided.

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdTask.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdTask.md)

