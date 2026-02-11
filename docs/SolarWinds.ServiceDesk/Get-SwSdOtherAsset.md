---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdOtherAsset.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdOtherAsset
---

# Get-SwSdOtherAsset

## SYNOPSIS

Returns the Service Desk other asset records for the specified criteria or all assets.

## SYNTAX

### __AllParameterSets

```
Get-SwSdOtherAsset [[-Name] <string>] [[-Manufacturer] <string>] [[-Model] <string>]
 [[-SerialNumber] <string>] [[-Id] <string>] [[-AssetId] <string>] [[-HREF] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the Service Desk other asset records for the specified criteria or all assets.

## EXAMPLES

### EXAMPLE 1

Get-SwSdOtherAsset -Name "Other Asset 1"

Returns the other asset record for the specified name.

### EXAMPLE 2

Get-SwSdOtherAsset -Manufacturer "Manufacturer A"

Returns the other asset records for the specified manufacturer.

### EXAMPLE 3

Get-SwSdOtherAsset -Model "Model B"

Returns the other asset records for the specified model.

### EXAMPLE 4

Get-SwSdOtherAsset -SerialNumber "1234567890"

Returns the other asset record for the specified serial number.

### EXAMPLE 5

Get-SwSdOtherAsset -Id "12345"

Returns the other asset record for the specified ID.

### EXAMPLE 6

Get-SwSdOtherAsset -AssetId "54321"

Returns the other asset record for the specified asset ID.

### EXAMPLE 7

Get-SwSdOtherAsset -HREF "https://api.samanage.com/other_assets/1234567890"

Returns the other asset record for the specified HREF.

### EXAMPLE 8

Get-SwSdOtherAsset

Returns all other asset records.

## PARAMETERS

### -AssetId

The other asset ID.
If provided, returns the specific asset record.

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

### -HREF

The other asset HREF.
If provided, returns the specific asset record.

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

### -Id

The other asset ID.
If provided, returns the specific asset record.

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

### -Manufacturer

The other asset manufacturer.
If provided, returns the specific asset record.

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

The other asset model.
If provided, returns the specific asset record.

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

The other asset name.
If provided, returns the specific asset record.

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

The other asset serial number.
If provided, returns the specific asset record.

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

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdOtherAsset.md)
