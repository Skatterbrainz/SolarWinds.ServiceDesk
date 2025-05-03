function Get-SwSdGroupMember {
	<#
	.SYNOPSIS
		Returns the members of the specified group.
	.DESCRIPTION
		Returns the members of the specified group.
	.PARAMETER Name
		The group name.
	.PARAMETER MemberName
		The member name or email address. If not specified, returns all members.
	.EXAMPLE
		Get-SwSdGroupMember -Name "Admins"

		Returns the members of the Admins group.
	.EXAMPLE
		Get-SwSdGroupMember -Name "Admins" -MemberName "jsmith@contoso.com"
		
		Returns the member record for the specified email address in the Admins group.
	.NOTES
		Reference: https://apidoc.samanage.com/#tag/Group
	.LINK
		https://github.com/Skatterbrainz/SolarWinds.ServiceDesk/blob/main/docs/Get-SwSdGroupMember.md
	
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $True)][string]$Name,
		[parameter(Mandatory = $False)][string]$MemberName
	)
	$group = Get-SwWdGroup -Name $Name
	if (![string]::IsNullOrEmpty($MemberName)) {
		$MemberName = $MemberName.ToLower()
		$group.memberships | Where-Object {
			$_.user.name.ToLower() -eq $MemberName -or
			$_.user.email.ToLower() -eq $MemberName
		}
	} else {
		$group.memberships
	}
}
