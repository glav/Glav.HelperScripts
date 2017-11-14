Write-Host "You will need to provide your credetials into the tenant"
$cred = Get-Credential

Write-Host "Getting users..."
Connect-MsolService -credential $cred
$role = Get-MsolRole -RoleName "Company Administrator"
Get-MsolRoleMember -RoleObjectId $role.ObjectId 

Write-Host "Done."
