---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md
schema: 2.0.0
---

# Get-SwSdUser

## SYNOPSIS
Returns the user record for the specified email address.

## SYNTAX

```
Get-SwSdUser [[-Email] <String>] [[-PageLimit] <Int32>] [[-PageCount] <Int32>] [-NoProgress]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the user record for the specified email address.
If no email address is specified, it returns all users.
Supports pagination with a specified page limit and page count.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdUser -Email "jsmith@contoso.com"
```

Returns the user record for the specified email address.

### EXAMPLE 2
```
Get-SwSdUser -PageCount 5
```

Returns the first 5 pages of user records.

### EXAMPLE 3
```
Get-SwSdUser -PageLimit 50
```

Returns a list of user records with a maximum of 50 records per page.

### EXAMPLE 4
```
Get-SwSdUser -NoProgress
```

Returns a list of user records without showing the progress indicator.

## PARAMETERS

### -Email
The user's email address.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageLimit
The maximum number of records to return per page.
Default is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageCount
The number of pages to return.
Default is 10.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoProgress
Suppress the progress indicator.

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
Reference: https://apidoc.samanage.com/#tag/User

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdUser.md)

