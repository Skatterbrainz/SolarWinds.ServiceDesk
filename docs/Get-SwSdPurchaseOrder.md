---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPurchaseOrder.md
schema: 2.0.0
---

# Get-SwSdPurchaseOrder

## SYNOPSIS
Returns the Service Desk purchase order records for the specified criteria or all purchase orders.

## SYNTAX

```
Get-SwSdPurchaseOrder [[-Name] <String>] [[-Id] <Int32>] [[-Status] <String>] [[-HREF] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk purchase order records for the specified criteria or all purchase orders.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdPurchaseOrder -Name "Purchase Order 1"
```

Returns the purchase order record for the specified name.

### EXAMPLE 2
```
Get-SwSdPurchaseOrder -Id "12345"
```

Returns the purchase order record for the specified ID.

### EXAMPLE 3
```
Get-SwSdPurchaseOrder -Status "Open"
```

Returns the purchase order records for the specified status.

### EXAMPLE 4
```
Get-SwSdPurchaseOrder -HREF "https://api.samanage.com/purchase_orders/1234567890"
```

Returns the purchase order record for the specified HREF.

### EXAMPLE 5
```
Get-SwSdPurchaseOrder
```

Returns all purchase order records.

## PARAMETERS

### -Name
The purchase order name.
If provided, returns the specific purchase order record.

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
The purchase order ID.
If provided, returns the specific purchase order record.

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

### -Status
The purchase order status.
If provided, returns the specific purchase order record.

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

### -HREF
The purchase order HREF.
If provided, returns the specific purchase order record.

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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPurchaseOrder.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdPurchaseOrder.md)

