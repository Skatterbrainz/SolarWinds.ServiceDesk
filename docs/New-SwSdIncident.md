---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# New-SwSdIncident

## SYNOPSIS
Creates a new incident in the Service Desk.

## SYNTAX

```
New-SwSdIncident [-Name] <String> [-Description] <String> [[-Priority] <String>] [[-Status] <String>]
 [[-Category] <String>] [[-SubCategory] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new incident in the Service Desk with the specified parameters.

## EXAMPLES

### EXAMPLE 1
```
New-SwSdIncident -Name "Test Incident" -Description "This is a test incident."
Creates a new incident with the name "Test Incident" and the description "This is a test incident."
```

### EXAMPLE 2
```
New-SwSdIncident -Name "Test Incident" -Description "This is a test incident." -Priority "High" -Status "In Progress"
Creates a new incident with the name "Test Incident", the description "This is a test incident.", priority "High", and status "In Progress".
```

## PARAMETERS

### -Name
The name of the incident.

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

### -Description
The description of the incident.

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

### -Priority
The priority of the incident.
Default is "Normal".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Normal
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
The status of the incident.
Default is "Pending Assignment".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Pending Assignment
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
The category of the incident.
Default is "General".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: General
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubCategory
The subcategory of the incident.
Default is "General".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: General
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
