---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdProblem.md
schema: 2.0.0
---

# Get-SwSdProblem

## SYNOPSIS
Returns the Service Desk problem records for the specified criteria or all problems.

## SYNTAX

```
Get-SwSdProblem [[-Name] <String>] [[-Id] <String>] [[-Status] <String>] [[-Priority] <String>]
 [[-HREF] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk problem records for the specified criteria or all problems.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdProblem -Name "Network Issue"
```

Returns the problem record for the specified name.

### EXAMPLE 2
```
Get-SwSdProblem -Id "12345"
```

Returns the problem record for the specified ID.

### EXAMPLE 3
```
Get-SwSdProblem -Status "Open"
```

Returns the problem records for the specified status.

### EXAMPLE 4
```
Get-SwSdProblem -Priority "High"
```

Returns the problem records for the specified priority.

### EXAMPLE 5
```
Get-SwSdProblem -HREF "https://api.samanage.com/problem/1234567890"
```

Returns the problem record for the specified HREF.

### EXAMPLE 6
```
Get-SwSdProblem
```

Returns all problem records.

## PARAMETERS

### -Name
The problem name or ID.
If provided, returns the specific problem record.

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

### -Id
The problem ID.
If provided, returns the specific problem record.

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

### -Status
The problem status.
If provided, returns the specific problem record.

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

### -Priority
The problem priority.
If provided, returns the specific problem record.

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

### -HREF
The problem HREF.
If provided, returns the specific problem record.

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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdProblem.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdProblem.md)

