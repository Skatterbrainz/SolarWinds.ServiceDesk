---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdHardware.md
schema: 2.0.0
---

# Get-SwSdHardware

## SYNOPSIS
Returns the Service Desk hardware records for the specified name or ID, or all hardware.

## SYNTAX

```
Get-SwSdHardware [[-Id] <String>] [[-Name] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk hardware records for the specified name or ID, or all hardware.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdHardware -Id 12345
```

Returns the hardware record for the specified ID.

### EXAMPLE 2
```
Get-SwSdHardware -Name "Laptop-001"
```

Returns the hardware record for the specified name.

## PARAMETERS

### -Id
The hardware ID. If provided, returns the specific hardware record.

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

### -Name
The hardware name. If provided, returns the specific hardware record.

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

### System.Management.Automation.PSObject
## NOTES
Reference: https://apidoc.samanage.com/#tag/Hardware

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdHardware.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdHardware.md)

