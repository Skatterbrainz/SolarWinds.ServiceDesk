---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Get-SwSDGroupMember

## SYNOPSIS
Returns the members of the specified group.

## SYNTAX

```
Get-SwSDGroupMember [-Name] <String> [[-MemberName] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the members of the specified group.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSDGroupMember -Name "Admins"
Returns the members of the Admins group.
```

### EXAMPLE 2
```
Get-SwSdGroupMember -Name "Admins" -MemberName "jsmith@contoso.com"
Returns the member record for the specified email address in the Admins group.
```

## PARAMETERS

### -Name
The group name.

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

### -MemberName
The member name or email address.
If not specified, returns all members.

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
