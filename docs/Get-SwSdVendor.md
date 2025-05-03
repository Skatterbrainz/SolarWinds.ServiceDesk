---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdVendor.md
schema: 2.0.0
---

# Get-SwSdVendor

## SYNOPSIS
Returns the Service Desk vendor records for the specified ID or all vendors.

## SYNTAX

```
Get-SwSdVendor [[-Name] <String>] [[-Id] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk vendor records for the specified ID or all vendors.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdVendor -Name "Vendor1"
```

Returns the vendor record for the specified name.

### EXAMPLE 2
```
Get-SwSdVendor -Id "12345"
```

Returns the vendor record for the specified ID.

### EXAMPLE 3
```
Get-SwSdVendor
```

Returns all vendor records.

## PARAMETERS

### -Name
The vendor name to search for.
If provided, returns the specific vendor record.

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
The vendor ID.
If provided, returns the specific vendor record.

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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdVendor.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdVendor.md)

