Login-AzureRmAccount
Get-AzureRmResource
Get-AzureRmResource | % { Write-Host $_.Name }
Get-AzureRmVM -Name SonarQubeDevOps -ResourceGroupName Default-Web-EastAsia
Get-AzureRmVM -Name SonarQubeDevOps -ResourceGroupName Default-Web-EastAsia -Status

