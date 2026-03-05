---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCategory.md
schema: 2.0.0
---

# Get-SwSdCategory

## SYNOPSIS
Retrieves a list of categories from SolarWinds Service Desk.

## SYNTAX

```
Get-SwSdCategory [[-Name] <String>] [[-Id] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves categories from SolarWinds Service Desk.
If no Name or Id is provided, returns all categories.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdCategory
```

Retrieves all categories.

### EXAMPLE 2
```
Get-SwSdCategory -Name "Software"
```

Retrieves the category with the name "Software".

### EXAMPLE 3
```
Get-SwSdCategory -Id 12345
```

Retrieves the category with the ID 12345.

## PARAMETERS

### -Name
Optional. The name of the category to retrieve.

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
Optional. The ID of the category to retrieve.

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

### System.Management.Automation.PSObject
## NOTES
Reference: https://apidoc.samanage.com/#tag/Category
Reference: https://apidoc.samanage.com/#tag/Category/operation/getCategoryById

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCategory.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdCategory.md)
