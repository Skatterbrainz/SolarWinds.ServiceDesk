---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdOtherAsset.md
schema: 2.0.0
---

# Get-SwSdOtherAsset

## SYNOPSIS
Returns the Service Desk other asset records for the specified criteria or all assets.

## SYNTAX

```
Get-SwSdOtherAsset [[-Name] <String>] [[-Manufacturer] <String>] [[-Model] <String>] [[-SerialNumber] <String>]
 [[-Id] <String>] [[-AssetId] <String>] [[-HREF] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk other asset records for the specified criteria or all assets.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdOtherAsset -Name "Other Asset 1"
```

Returns the other asset record for the specified name.

### EXAMPLE 2
```
Get-SwSdOtherAsset -Manufacturer "Manufacturer A"
```

Returns the other asset records for the specified manufacturer.

### EXAMPLE 3
```
Get-SwSdOtherAsset -Model "Model B"
```

Returns the other asset records for the specified model.

### EXAMPLE 4
```
Get-SwSdOtherAsset -SerialNumber "1234567890"
```

Returns the other asset record for the specified serial number.

### EXAMPLE 5
```
Get-SwSdOtherAsset -Id "12345"
```

Returns the other asset record for the specified ID.

### EXAMPLE 6
```
Get-SwSdOtherAsset -AssetId "54321"
```

Returns the other asset record for the specified asset ID.

### EXAMPLE 7
```
Get-SwSdOtherAsset -HREF "https://api.samanage.com/other_assets/1234567890"
```

Returns the other asset record for the specified HREF.

### EXAMPLE 8
```
Get-SwSdOtherAsset
```

Returns all other asset records.

## PARAMETERS

### -Name
The other asset name.
If provided, returns the specific asset record.

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

### -Manufacturer
The other asset manufacturer.
If provided, returns the specific asset record.

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

### -Model
The other asset model.
If provided, returns the specific asset record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SerialNumber
The other asset serial number.
If provided, returns the specific asset record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The other asset ID.
If provided, returns the specific asset record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssetId
The other asset ID.
If provided, returns the specific asset record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HREF
The other asset HREF.
If provided, returns the specific asset record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdOtherAsset.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdOtherAsset.md)

