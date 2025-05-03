---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPrinter.md
schema: 2.0.0
---

# Get-SwSdPrinter

## SYNOPSIS
Returns the Service Desk printer records for the specified ID or all printers.

## SYNTAX

```
Get-SwSdPrinter [[-Name] <String>] [[-Id] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk printer records for the specified ID or all printers.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdPrinter -Name "Printer1"
```

Returns the printer record for the specified name.

### EXAMPLE 2
```
Get-SwSdPrinter -Id "12345"
```

Returns the printer record for the specified ID.

### EXAMPLE 3
```
Get-SwSdPrinter
```

Returns all printer records.

## PARAMETERS

### -Name
The printer name.
If provided, returns the specific printer record.

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

### -Id
The printer ID.
If provided, returns the specific printer record.

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

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPrinter.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPrinter.md)

