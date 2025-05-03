---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Export-SwSdIncidentDetails.md
schema: 2.0.0
---

# Export-SwSdIncidentDetails

## SYNOPSIS
Exports the incident details information to a file.

## SYNTAX

```
Export-SwSdIncidentDetails [-Number] <String> [-SaveToFile] [[-OutputPath] <String>] [-Show]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Exports the incident details (description property) information to a file.

## EXAMPLES

### EXAMPLE 1
```
Export-SwSdIncidentDetails -Number 12345 -SaveToFile
```

Exports the incident details for incident number 12345 to a file.

### EXAMPLE 2
```
Export-SwSdIncidentDetails -Number 12345 -SaveToFile -OutputPath "C:\Temp"
```

Exports the incident details for incident number 12345 to a file in the specified path.

### EXAMPLE 3
```
Export-SwSdIncidentDetails -Number 12345 -Show
```

Exports the incident details for incident number 12345 and displays it in the default web browser.

## PARAMETERS

### -Number
The incident number.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SaveToFile
Save the request data to a file.

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

### -OutputPath
The path to save the file.
Default is the user's Documents folder.

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

### -Show
Display the exported HTML request data in the default web browser.

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
Reference: https://apidoc.samanage.com/#tag/Incident

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Export-SwSdIncidentDetails.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Export-SwSdIncidentDetails.md)

