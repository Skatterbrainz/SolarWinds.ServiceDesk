---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdMobileDevice.md
schema: 2.0.0
---

# Get-SwSdMobileDevice

## SYNOPSIS
Returns the Service Desk mobile device records for the specified criteria or all devices.

## SYNTAX

```
Get-SwSdMobileDevice [[-Name] <String>] [[-Manufacturer] <String>] [[-Model] <String>]
 [[-SerialNumber] <String>] [[-Id] <String>] [[-ServiceProvider] <String>] [[-IMEI] <String>]
 [[-HREF] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk mobile device records for the specified criteria or all devices.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdMobileDevice -Name "iPhone 12"
```

Returns the mobile device record for the specified name.

### EXAMPLE 2
```
Get-SwSdMobileDevice -Manufacturer "Apple"
```

Returns the mobile device records for the specified manufacturer.

### EXAMPLE 3
```
Get-SwSdMobileDevice -Model "Galaxy S21"
```

Returns the mobile device records for the specified model.

### EXAMPLE 4
```
Get-SwSdMobileDevice -SerialNumber "1234567890"
```

Returns the mobile device record for the specified serial number.

### EXAMPLE 5
```
Get-SwSdMobileDevice -Id "12345"
```

Returns the mobile device record for the specified ID.

### EXAMPLE 6
```
Get-SwSdMobileDevice -ServiceProvider "Verizon"
```

Returns the mobile device records for the specified service provider.

### EXAMPLE 7
```
Get-SwSdMobileDevice -IMEI "123456789012345"
```

Returns the mobile device record for the specified IMEI.

### EXAMPLE 8
```
Get-SwSdMobileDevice -HREF "https://api.samanage.com/mobiles/1234567890"
```

Returns the mobile device record for the specified HREF.

### EXAMPLE 9
```
Get-SwSdMobileDevice
```

Returns all mobile device records.

## PARAMETERS

### -Name
The mobile device name.
If provided, returns the specific device record.

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
The mobile device manufacturer.
If provided, returns the specific device record.

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
The mobile device model.
If provided, returns the specific device record.

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
The mobile device serial number.
If provided, returns the specific device record.

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
The mobile device ID.
If provided, returns the specific device record.

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

### -ServiceProvider
The mobile device service provider.
If provided, returns the specific device record.

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

### -IMEI
The mobile device IMEI.
If provided, returns the specific device record.

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

### -HREF
The mobile device HREF.
If provided, returns the specific device record.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdMobileDevice.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdMobileDevice.md)

