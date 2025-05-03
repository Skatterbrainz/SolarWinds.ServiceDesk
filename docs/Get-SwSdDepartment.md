---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdDepartment.md
schema: 2.0.0
---

# Get-SwSdDepartment

## SYNOPSIS
Returns the Service Desk department records for the specified ID or all departments.

## SYNTAX

```
Get-SwSdDepartment [[-Name] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk department records for the specified ID or all departments.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdDepartment -Name "IT"
```

Returns the department record for the specified name.

### EXAMPLE 2
```
Get-SwSdDepartment -Name "12345"
```

Returns the department record for the specified ID.

### EXAMPLE 3
```
Get-SwSdDepartment
```

Returns all department records.

## PARAMETERS

### -Name
The department name or ID.
If provided, returns the specific department record.

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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdDepartment.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdDepartment.md)

