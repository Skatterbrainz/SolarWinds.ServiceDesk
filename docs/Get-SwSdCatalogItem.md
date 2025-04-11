---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCatalogItem.md
schema: 2.0.0
---

# Get-SwSdCatalogItem

## SYNOPSIS
Returns the catalog item records for the specified ID or all catalog items.

## SYNTAX

```
Get-SwSdCatalogItem [[-Id] <String>] [[-Name] <String>] [[-Tag] <String>] [[-PageLimit] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the catalog item records for the specified ID or all catalog items.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdCatalogItem -Id 12345
Returns the catalog item record for the specified ID.
```

### EXAMPLE 2
```
Get-SwSdCatalogItem -Name "New User"
Returns the catalog item record for the specified name.
```

### EXAMPLE 3
```
Get-SwSdCatalogItem -Tag "New User"
Returns the catalog item record for the specified tag.
```

### EXAMPLE 4
```
Get-SwSdCatalogItem -PageLimit 50
Returns a list of catalog items with a maximum of 50 records per page.
```

## PARAMETERS

### -Id
The catalog item ID.

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
The catalog item name.

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

### -Tag
The catalog item tag.

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

### -PageLimit
The maximum number of records to return per page.
Default is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 100
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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCatalogItem.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCatalogItem.md)

