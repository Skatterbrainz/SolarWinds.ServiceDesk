---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Get-SwSDHardware

## SYNOPSIS
Returns the hardware records for the specified ID or all hardware.

## SYNTAX

```
Get-SwSDHardware [[-Id] <String>] [[-PageCount] <Int32>] [[-PageLimit] <Int32>] [-NoProgress]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the hardware records for the specified ID or all hardware.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSDHardware -Id 12345
Returns the hardware record for the specified ID.
```

### EXAMPLE 2
```
Get-SwSDHardware -PageCount 5
Returns the first 5 pages of hardware records.
```

## PARAMETERS

### -Id
The hardware ID.

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

### -PageCount
The number of pages to return.
Default is 0 (all pages).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageLimit
The maximum number of records to return per page.
Default is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoProgress
Suppress the progress indicator.

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
