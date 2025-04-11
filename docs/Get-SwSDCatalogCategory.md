---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Get-SwSDCatalogCategory

## SYNOPSIS
Returns a catalog category or returns all categories.

## SYNTAX

```
Get-SwSDCatalogCategory [[-Id] <Int32>] [[-Name] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a catalog category or returns all categories.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSDCatalogCategories
Returns the catalog categories.
```

### EXAMPLE 2
```
Get-SwSDCatalogCategory -Id 12345
Returns the catalog category for the specified ID.
```

### EXAMPLE 3
```
Get-SwSDCatalogCategory -Name "Mobile Devices"
Returns the catalog category for the specified name.
```

## PARAMETERS

### -Id
The catalog category ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The catalog category name.

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
