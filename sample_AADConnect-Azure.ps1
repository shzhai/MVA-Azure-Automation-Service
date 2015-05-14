workflow AADConnect-Azure
{
    $AzureConnectionName = 'Windows Azure Internal Consumption'
    $Cred = Get-AutomationPSCredential -Name 'automationadmin@shzhailab.partner.onmschina.cn'
    add-azureaccount -Environment AzureChinaCloud -Credential $Cred
    Select-azuresubscription -subscriptionname $AzureConnectionName
}