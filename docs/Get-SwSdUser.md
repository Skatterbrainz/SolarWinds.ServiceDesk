---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md
schema: 2.0.0
---

# Get-SwSdUser

## SYNOPSIS
Returns the Service Desk user records for the specified email or ID.

## SYNTAX

```
Get-SwSdUser [[-Email] <String>] [[-Id] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns Service Desk user records for the specified email address or ID.
If no email or ID is specified, returns all users.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdUser -Email "jsmith@contoso.com"
```

Returns the user record for the specified email address.

### EXAMPLE 2
```
Get-SwSdUser -Id 12345
```

Returns the user record for the specified ID.

## PARAMETERS

### -Email
The user's email address.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

### -Id
The user ID. If provided, returns the specific user record.
Accept pipeline input: False
Accept wildcard characters: False
Type: String

### -PageLimit
The maximum number of records to return per page.
Default is 100.

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

### System.Management.Automation.PSObject
## NOTES
Reference: https://apidoc.samanage.com/#tag/User

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md)

