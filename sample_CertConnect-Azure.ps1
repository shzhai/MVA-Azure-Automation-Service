workflow CertConnect-Azure
{
    $AzureConnectionName = 'Windows Azure Internal Consumption'
    Connect-Azure -AzureConnectionName $AzureConnectionName
    Select-Azuresubscription -SubscriptionName $AzureConnectionName
}