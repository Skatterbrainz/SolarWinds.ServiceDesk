---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAPI.md
schema: 2.0.0
---

# Get-SwSdAPI

## SYNOPSIS
Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.

## SYNTAX

```
Get-SwSdAPI [[-Name] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the SolarWinds Service Desk API URL for the specified API $Name, or returns the list of available APIs.
Caches list to global variable $SDAPIList, to minimize API calls.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdAPI -Name "Incidents List"
Returns the URL for the Incidents List API
```

### EXAMPLE 2
```
Get-SwSdAPI
Returns all API URLs
```

### EXAMPLE 3
```
Get-SwSdAPI -Name "Search"
Returns the URL for the Search API
```

## PARAMETERS

### -Name
The name of the API to retrieve.
If not specified, returns the list of available APIs.

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
Reference: https://apidoc.samanage.com/#section/General-Concepts/API-Entry-Point

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAPI.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAPI.md)

