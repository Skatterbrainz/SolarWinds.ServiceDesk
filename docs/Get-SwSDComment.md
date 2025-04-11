---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Get-SwSDComment

## SYNOPSIS
Returns the comments for the specified incident.

## SYNTAX

```
Get-SwSDComment [-IncidentNumber] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the comments for the specified incident.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSDComment -IncidentNumber 12345
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
