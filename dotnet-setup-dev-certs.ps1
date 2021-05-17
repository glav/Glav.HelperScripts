param( 
	[Parameter(Mandatory=$true)]
	[string]
	$certificatePassword
)

Write-Host "This will clean your existing developer certificates, generate new ones with the password [$certificatePassword] and trust those certificates."
$confirm = Read-Host -Prompt "Are you sure? (N/y)"

if ($confirm -eq $null -or $confirm -eq "" -or $confirm -eq "n")
{
	Write-Host "Exiting"
	return;
}

Write-Host "Please answer all prompts presented to complete this process" -ForegroundColor Yellow

Write-Host "Clearing and rer-installing development certificates using password:"
Write-Host $certificatePassword -ForegroundColor Green
dotnet dev-certs https --clean
dotnet dev-certs https -ep $env:USERPROFILE\.aspnet\https\aspnetapp.pfx -p $certificatePassword
dotnet dev-certs https --trust
