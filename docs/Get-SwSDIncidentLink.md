---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Get-SwSDIncidentLink

## SYNOPSIS

## SYNTAX

```
Get-SwSDIncidentLink [-Number] <String> [-Name] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Generates a unique URL for the specified incident ID and name.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSDIncidentLink -Number 149737766 -Name "NH 2/18/25 Abenaa Ampem MBL WKR PKG #1 3000000"
Returns: 149737766-nh-2-18-25-abenaa-ampem-mbl-wkr-pkg-1-3000000.json
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

### -Name
The incident name.

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
This is also the tail end of the \[href\] property of an incident.

## RELATED LINKS
