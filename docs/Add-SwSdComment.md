---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Add-SwSdComment.md
schema: 2.0.0
---

# Add-SwSdComment

## SYNOPSIS
Adds a comment to the specified incident.

## SYNTAX

```
Add-SwSdComment [-IncidentNumber] <String> [-Comment] <String> [-Assignee] <String> [-Private]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Adds a comment to the specified incident.
The comment can be made private and assigned to a user.

## EXAMPLES

### EXAMPLE 1
```
Add-SwSdComment -IncidentNumber 12345 -Comment "This is a comment." -Assignee "jsmith@contoso.com"
```

Adds a comment to the specified incident number with the provided comment and assignee.

### EXAMPLE 2
```
Add-SwSdComment -IncidentNumber 12345 -Comment "This is a new comment" -Assignee "jsmith@contoso.com" -Private
```

Adds a private comment to the specified incident number with the provided comment and assignee.

## PARAMETERS

### -IncidentNumber
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

### -Comment
The comment to add.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Assignee
The email address of the assignee.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Private
Make the comment private.

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
The Assignee must be a valid SWSD user account.
Reference: https://apidoc.samanage.com/#tag/Incident
Reference: https://apidoc.samanage.com/#tag/Comment

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Add-SwSdComment.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Add-SwSdComment.md)

