function Get-SwSDGroupMember {
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
		Get-SwSDGroupMember -Name "Admins"
		Returns the members of the Admins group.
	.EXAMPLE
		Get-SwSdGroupMember -Name "Admins" -MemberName "jsmith@contoso.com"
		Returns the member record for the specified email address in the Admins group.
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string]$Name,
		[parameter()][string]$MemberName
	)
	$group = Get-SwWDGroup -Name $Name
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
