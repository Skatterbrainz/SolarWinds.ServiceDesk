---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdUser.md
schema: 2.0.0
---

# New-SwSdUser

## SYNOPSIS
Creates a new user in SolarWinds Service Desk.

## SYNTAX

```
New-SwSdUser [-Name] <String> [-Email] <String> [[-Role] <String>] [[-ReportsTo] <String>] [[-Phone] <String>] [[-MobilePhone] <String>] [[-Department] <String>] [[-Site] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new user in SolarWinds Service Desk with the specified parameters.

## EXAMPLES

### EXAMPLE 1
```
New-SwSdUser -Name "John Doe" -Email "john.doe@example.com" -Role "Agent"
```

Creates a new user with the specified name, email, and role.

## PARAMETERS

### -Name
Required. The full name of the user.

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

### -Email
Required. The email address of the user.

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

### -Role
Optional. The role of the user.

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

### -ReportsTo
Optional. The email address of the user's manager.

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

### -Phone
Optional. The phone number of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MobilePhone
Optional. The mobile phone number of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Department
Optional. The department of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Site
Optional. The site of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Reference: https://apidoc.samanage.com/#tag/User/operation/createUser

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdUser.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdUser.md)
