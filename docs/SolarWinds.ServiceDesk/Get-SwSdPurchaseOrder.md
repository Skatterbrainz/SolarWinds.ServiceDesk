---
document type: cmdlet
external help file: SolarWinds.ServiceDesk-Help.xml
HelpUri: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPurchaseOrder.md
Locale: en-US
Module Name: SolarWinds.ServiceDesk
ms.date: 02/11/2026
PlatyPS schema version: 2024-05-01
title: Get-SwSdPurchaseOrder
---

# Get-SwSdPurchaseOrder

## SYNOPSIS

Returns the Service Desk purchase order records for the specified criteria or all purchase orders.

## SYNTAX

### __AllParameterSets

```
Get-SwSdPurchaseOrder [[-Name] <string>] [[-Id] <int>] [[-Status] <string>] [[-HREF] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Returns the Service Desk purchase order records for the specified criteria or all purchase orders.

## EXAMPLES

### EXAMPLE 1

Get-SwSdPurchaseOrder -Name "Purchase Order 1"

Returns the purchase order record for the specified name.

### EXAMPLE 2

Get-SwSdPurchaseOrder -Id "12345"

Returns the purchase order record for the specified ID.

### EXAMPLE 3

Get-SwSdPurchaseOrder -Status "Open"

Returns the purchase order records for the specified status.

### EXAMPLE 4

Get-SwSdPurchaseOrder -HREF "https://api.samanage.com/purchase_orders/1234567890"

Returns the purchase order record for the specified HREF.

### EXAMPLE 5

Get-SwSdPurchaseOrder

Returns all purchase order records.

## PARAMETERS

### -HREF

The purchase order HREF.
If provided, returns the specific purchase order record.

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

### -Id

The purchase order ID.
If provided, returns the specific purchase order record.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -Name

The purchase order name.
If provided, returns the specific purchase order record.

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

### -Status

The purchase order status.
If provided, returns the specific purchase order record.

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

- [](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPurchaseOrder.md)
