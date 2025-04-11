---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Connect-SwSD.md
schema: 2.0.0
---

# Connect-SwSD

## SYNOPSIS
Creates a new SolarWinds Service Desk session.

## SYNTAX

```
Connect-SwSD [[-ApiToken] <String>] [[-ApiUrl] <String>] [[-ApiVersion] <String>] [[-ApiFormat] <String>]
 [-Refresh] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new SolarWinds Service Desk session.
If a session already exists, it will return the existing session unless the \`-Refresh\` switch is used.
You can provide the API token, URL, version, and format as parameters.
If the API token is not provided, it will look for the \`$env:SWSDToken\` environment variable.
You can also set the API URL, version, and format as parameters.
The default values are:
	- ApiUrl: "https://api.samanage.com"
	- ApiVersion: "v2.1"
	- ApiFormat: "json"

## EXAMPLES

### EXAMPLE 1
```
Connect-SwSD -ApiToken "your_api_token"
Creates a new SolarWinds Service Desk session with the specified API token.
```

### EXAMPLE 2
```
Connect-SwSD -ApiUrl "https://api.samanage.com" -ApiVersion "v2.1" -ApiFormat "json"
Creates a new SolarWinds Service Desk session with the specified API URL, version, and format.
```

### EXAMPLE 3
```
Connect-SwSD -Refresh
Refreshes the existing SolarWinds Service Desk session.
```

## PARAMETERS

### -ApiToken
The authentication API token.
This is required if not set in the environment variable \`$env:SWSDToken\`.

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

### -ApiUrl
The API URL.
Default is "https://api.samanage.com".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Https://api.samanage.com
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiVersion
The API version.
Default is "v2.1".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: V2.1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiFormat
The API format: json or xml.
Default is "json".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Json
Accept pipeline input: False
Accept wildcard characters: False
```

### -Refresh
Refresh the session.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
Reference: https://apidoc.samanage.com/#section/General-Concepts/Service-URL

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Connect-SwSD.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Connect-SwSD.md)

