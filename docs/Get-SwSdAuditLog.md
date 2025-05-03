---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAuditLog.md
schema: 2.0.0
---

# Get-SwSdAuditLog

## SYNOPSIS
Returns the Service Desk audit log records for the specified ID or all audit logs.

## SYNTAX

```
Get-SwSdAuditLog [[-Id] <String>] [[-PageLimit] <Int32>] [[-Limit] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the Service Desk audit log records for the specified ID or all audit logs.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdAuditLog -Id 12345
```

Returns the audit log record for the specified ID.

### EXAMPLE 2
```
Get-SwSdAuditLog -PageLimit 50
```

Returns a list of audit logs with a maximum of 50 records per page.

### EXAMPLE 3
```
Get-SwSdAuditLog -Limit 200
```

Returns a list of audit logs with a maximum of 200 records.

## PARAMETERS

### -Id
The audit log ID.
If provided, returns the specific audit log record.

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

### -Limit
The maximum number of records to return.
Default is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 100
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

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAuditLog.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdAuditLog.md)

