---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Get-SwSDUser

## SYNOPSIS

## SYNTAX

```
Get-SwSDUser [[-Email] <String>] [[-PageLimit] <Int32>] [[-PageCount] <Int32>] [-NoProgress]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the user record for the specified email address.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSDUser -Email "jsmith@contoso.com"
```

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

## RELATED LINKS
