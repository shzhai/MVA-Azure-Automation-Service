workflow Backup-AzureServiceVM
{
    Param (
        
        [parameter(Mandatory=$true)]
        [String]
        $AzureConnectionName = 'Windows Azure Internal Consumption',
        [parameter(Mandatory=$true)]
        [String]
        $PSCredentialName = 'automationadmin@shzhailab.partner.onmschina.cn',
        [parameter(Mandatory=$true)]
        [String]
        $ChildJob = 'Test-AzureVMBackup',
        [parameter(Mandatory=$true)]
        [String]
        $StorageAccountName = 'mysqldbstorage',
        [parameter(Mandatory=$true)]
        [String]
        $ContainerName = 'vhdbackup',
        [parameter(Mandatory=$true)]
        [String]
        $AutomationAccountName = 'shzhaiautomationaccount',
        [Parameter(Mandatory=$true)]
        [array]
        $services
    
    )
    $AzureConnectionName = $AzureConnectionName 
    $Cred = Get-AutomationPSCredential -Name $PSCredentialName
    add-azureaccount -Environment AzureChinaCloud -Credential $Cred
    Select-azuresubscription -subscriptionname $AzureConnectionName
    
    # [String[]]$Services = @("shzhaidemo")
    Foreach ($Service in $Services) 
    {
        Start-AzureAutomationRunbook -Name $ChildJob -AutomationAccountName $AutomationAccountName -Parameters  @{"ServiceName" = $Service;"StorageAccountName" = $StorageAccountName;"ContainerName" = $ContainerName}
    }
}
