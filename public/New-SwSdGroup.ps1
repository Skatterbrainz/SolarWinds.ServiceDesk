function New-SwSdGroup {
    <#
    .SYNOPSIS
        Creates a new group in SolarWinds Service Desk.
    .DESCRIPTION
        Creates a new group in SolarWinds Service Desk by making an API call to the appropriate endpoint.
    .PARAMETER Name
        The name of the group to create.
    .PARAMETER Description
        A description for the group.
    .PARAMETER SupervisorID
        The user ID of the group supervisor.
    .EXAMPLE
        New-SwSdGroup -Name "New Group"

        Creates a new group named "New Group".
    .EXAMPLE
        New-SwSdGroup -Name "New Group" -Description "This is a new group."

        Creates a new group named "New Group" with the specified description.
    .EXAMPLE
        New-SwSdGroup -Name "New Group" -SupervisorID 123456

        Creates a new group named "New Group" with the specified supervisor.
    .LINK
        https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/New-SwSdGroup.md
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $True)][string]$Name,
        [parameter(Mandatory = $False)][string]$Description,
        [parameter(Mandatory = $False)]$SupervisorID
    )
    try {
        $url = "$($SDSession.url)/api/groups"
        $body = @{
            name = $Name
        }
        if (![string]::IsNullOrEmpty($Description)) {
            $body.description = $Description
        }
        if ($SupervisorID) {
            $body.supervisor_id = $SupervisorID
        }
        $body = $body | ConvertTo-Json
        $params = @{
            Uri             = $url
            Method          = 'Post'
            Headers         = $SDSession.headers
            ContentType     = 'application/json'
            Body            = $body
            ErrorAction     = 'Stop'
            UseBasicParsing = $true
        }
        Write-Verbose "Creating group with parameters: $($params | Out-String)"
        $response = Invoke-SwSdWebRequest @params | Select-Object -ExpandProperty Content | ConvertFrom-Json
        if ($response.StatusCode -eq 200) {
            Write-Verbose "Group $Name created successfully."
            [PSCustomObject]@{
                Name = $Name
                Id   = $response.id
            }
        } else {
            Write-Warning "Failed to create group $Name. Status code: $($response.StatusCode)"
        }
    } catch {
        [pscustomobject]@{
            Status    = 'Error'
            Activity  = $($_.CategoryInfo.Activity -join (";"))
            Message   = $($_.Exception.Message -join (";"))
            Trace     = $($_.ScriptStackTrace -join (";"))
            GroupName = $Name
        }
    }
}