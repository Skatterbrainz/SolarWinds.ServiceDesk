---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdSite.md
schema: 2.0.0
---

# Get-SwSdSite

## SYNOPSIS
Returns the Service Desk site records for the specified ID or all sites.

## SYNTAX

```
Get-SwSdSite [[-Name] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk site records for the specified ID or all sites.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdSite -Name "Main Office"
```

Returns the site record for the specified name.

### EXAMPLE 2
```
Get-SwSdSite -Name "12345"
```

Returns the site record for the specified ID.

### EXAMPLE 3
```
Get-SwSdSite
```

Returns all site records.

## PARAMETERS

### -Name
The site name or ID.
If provided, returns the specific site record.

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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdSite.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdSite.md)

