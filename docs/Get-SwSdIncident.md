---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdIncident.md
schema: 2.0.0
---

# Get-SwSdIncident

## SYNOPSIS
Returns a Service Desk incident or list of incidents.

## SYNTAX

```
Get-SwSdIncident [[-Number] <String>] [[-Id] <Int32>] [[-Name] <String>] [[-Status] <String>]
 [[-PageLimit] <Int32>] [[-PageCount] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
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
Get-SwSdIncident -Number 12345
Returns the incident record for incident number 12345.
```

### EXAMPLE 2
```
Get-SwSdIncident -Id 123456789 -Name "Incident Name"
Returns the incident record for incident ID 12345 with the specified name.
```

### EXAMPLE 3
```
Get-SwSdIncident -Status "Pending Assignment" -Name "Incident Name"
Returns a list of incidents with status "Pending Assignment" and name "Incident Name".
```

### EXAMPLE 4
```
Get-SwSdIncident -Status "Pending Assignment" -PageLimit 50 -PageCount 2
Returns a list of incidents with status "Pending Assignment", with a maximum of 50 records per page, and returns 2 pages.
```

## PARAMETERS

### -Number
The incident number.

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
The incident ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The incident name.
Required if Id is provided.

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

### -Status
The status of the incident, for example "Pending Assignment", "Assigned", "Closed", etc.

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

### -PageLimit
The maximum number of records to return per page.
Default is 100.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
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
Reference: https://apidoc.samanage.com/#tag/Incident

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdIncident.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdIncident.md)

