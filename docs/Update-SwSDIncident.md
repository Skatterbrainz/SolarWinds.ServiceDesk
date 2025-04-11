---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Update-SwSDIncident

## SYNOPSIS

## SYNTAX

```
Update-SwSDIncident [-Number] <String> [[-Assignee] <String>] [[-Status] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Updates the specified incident record with the provided assignee and/or status.

## EXAMPLES

### EXAMPLE 1
```
Update-SwSDIncident -Number 12345 -Assignee "jsmith@contoso.org" -Status "Pending Assignment"
```

## PARAMETERS

### -Number
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

### -Status
The status of the incident: Awaiting Input, Assigned, Closed, On Hold, Pending Assignment, Scheduled.
The default status is 'Assigned'.

```yaml
Type: String
Parameter Sets: (All)
Aliases: State

Required: False
Position: 3
Default value: Pending Assignment
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
