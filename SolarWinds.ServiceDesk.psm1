('public') | Foreach-Object {
	Get-ChildItem -Path $(Join-Path -Path $PSScriptRoot -ChildPath $_) -Filter "*.ps1" | Foreach-Object {
		Write-Verbose $_.FullName
		. $_.FullName
	}
}
