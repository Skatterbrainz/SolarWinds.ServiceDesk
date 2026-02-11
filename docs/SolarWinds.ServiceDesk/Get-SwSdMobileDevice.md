---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdMobileDevice.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdMobileDevice
---

# Get-SwSdMobileDevice

## SYNOPSIS

Returns the Service Desk mobile device records for the specified criteria or all devices.

## SYNTAX

### __AllParameterSets

```
Get-SwSdMobileDevice [[-Name] <string>] [[-Manufacturer] <string>] [[-Model] <string>]
 [[-SerialNumber] <string>] [[-Id] <string>] [[-ServiceProvider] <string>] [[-IMEI] <string>]
 [[-HREF] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the Service Desk mobile device records for the specified criteria or all devices.

## EXAMPLES

### EXAMPLE 1

Get-SwSdMobileDevice -Name "iPhone 12"

Returns the mobile device record for the specified name.

### EXAMPLE 2

Get-SwSdMobileDevice -Manufacturer "Apple"

Returns the mobile device records for the specified manufacturer.

### EXAMPLE 3

Get-SwSdMobileDevice -Model "Galaxy S21"

Returns the mobile device records for the specified model.

### EXAMPLE 4

Get-SwSdMobileDevice -SerialNumber "1234567890"

Returns the mobile device record for the specified serial number.

### EXAMPLE 5

Get-SwSdMobileDevice -Id "12345"

Returns the mobile device record for the specified ID.

### EXAMPLE 6

Get-SwSdMobileDevice -ServiceProvider "Verizon"

Returns the mobile device records for the specified service provider.

### EXAMPLE 7

Get-SwSdMobileDevice -IMEI "123456789012345"

Returns the mobile device record for the specified IMEI.

### EXAMPLE 8

Get-SwSdMobileDevice -HREF "https://api.samanage.com/mobiles/1234567890"

Returns the mobile device record for the specified HREF.

### EXAMPLE 9

Get-SwSdMobileDevice

Returns all mobile device records.

## PARAMETERS

### -HREF

The mobile device HREF.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Id

The mobile device ID.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IMEI

The mobile device IMEI.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Manufacturer

The mobile device manufacturer.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Model

The mobile device model.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The mobile device name.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SerialNumber

The mobile device serial number.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ServiceProvider

The mobile device service provider.
If provided, returns the specific device record.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject

{{ Fill in the Description }}

## NOTES

## RELATED LINKS

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdMobileDevice.md)
