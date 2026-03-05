---
external help file: SolarWinds.ServiceDesk-help.xml
Module Name: SolarWinds.ServiceDesk
online version: https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdQueue.md
schema: 2.0.0
---

# Get-SwSdQueue

## SYNOPSIS
Returns assignable queue records.

## SYNTAX

```
Get-SwSdQueue [[-Name] <String>] [[-Id] <Int32>] [-Force] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns assignable queue records from the Service Desk API.
List mode (no -Name or -Id) queries only queue endpoints (for example assignment_queues, assignable_queues, or queues) to avoid mixing in non-queue groups.
Name mode first queries queue endpoints, then falls back to group lookup/filtering for tenant compatibility.

## EXAMPLES

### EXAMPLE 1
```
Get-SwSdQueue
```

Returns all assignable queues.

### EXAMPLE 2
```
Get-SwSdQueue -Name "IT Help Desk Team Queue"
```

Returns queue details for the specified queue name.

### EXAMPLE 3
```
Get-SwSdQueue -Id 6873849
```

Returns queue details for the specified queue id.

## PARAMETERS

### -Name
The queue name. If not specified, returns all queues.

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
The queue ID. If not specified, returns all queues.

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

### -Force
Force refresh of the API endpoint list before lookup.

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

### System.Management.Automation.PSObject
## NOTES
Queues are represented in some tenants as AssignableQueueGroup entities.
Depending on tenant/API version, queues may be exposed as assignment_queues or assignable_queues.
When using no parameters, no queue endpoint results means no output (by design).
Reference: https://apidoc.samanage.com/#tag/Group/operation/getGroups

## RELATED LINKS

[https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdQueue.md](https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdQueue.md)
