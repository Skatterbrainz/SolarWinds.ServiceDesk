---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version:
schema: 2.0.0
---

# Get-SwSDIncident

## SYNOPSIS
Returns a Service Desk incident or list of incidents.

## SYNTAX

### Number
```
Get-SwSDIncident [-Number <String>] [-Status <String>] [-PageLimit <Int32>] [-PageCount <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ID
```
Get-SwSDIncident [-Id <Int32>] [-Name <String>] [-Status <String>] [-PageLimit <Int32>] [-PageCount <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns a Service Desk incident for the specified incident Number or ID + name.
If Number and Id are not provided, it returns a list of incidents.
When requesting a list of incidents, the status and name can be used to filter the results.
By default, it returns 100 records per page.
The maximum number of pages is 0 (all pages).

## EXAMPLES

### EXAMPLE 1
```
Get-SwSDIncident -Number 12345
Returns the incident record for incident number 12345.
```

### EXAMPLE 2
```
Get-SwSDIncident -Id 123456789 -Name "Incident Name"
Returns the incident record for incident ID 12345 with the specified name.
```

## PARAMETERS

### -Number
The incident number.

```yaml
Type: String
Parameter Sets: Number
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The incident ID.

```yaml
Type: Int32
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The incident name.
Required if Id is provided.

```yaml
Type: String
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
The status of the incident, for example "Pending Assignment", "Assigned", "Closed", etc.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageCount
The number of pages to return.
Default is 0 (all pages).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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
