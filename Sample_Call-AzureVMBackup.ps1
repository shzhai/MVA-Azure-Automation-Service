workflow Test-AzureVMBackup

{   Param
    (
        [parameter(Mandatory=$false)]
        [String]
        $AzureConnectionName = 'Windows Azure Internal Consumption',
        [parameter(Mandatory=$false)]
        [String]
        $PSCredentialName = 'automationadmin@shzhailab.partner.onmschina.cn',
        [parameter(Mandatory=$true)]
        [String]
        $ServiceName = 'shzhaidemo',
        [parameter(Mandatory=$true)]
        [String]
        $StorageAccountName = 'mysqldbstorage',
        [parameter(Mandatory=$true)]
        [String]
        $ContainerName = 'vhdbackup',
        [Parameter(Mandatory=$false)]
        [int] 
        $PollingIntervalInSeconds = 10,
        [Parameter(Mandatory=$false)]
        [int] 
        $PollingTimeoutInSeconds = 300
    )

    # Set up Azure connection
    
    $Cred = Get-AutomationPSCredential -Name $PSCredentialName
    add-azureaccount -Environment AzureChinaCloud -Credential $Cred
    Select-azuresubscription -subscriptionname $AzureConnectionName
    

    # Stop Azure VM
    
   $VMNames = (get-Azurevm -ServiceName $serviceName).name 
    
    foreach ($VMName in $VMNames) {
                  
            Stop-AzureVM -ServiceName $ServiceName -Name $VMName –StayProvisioned
            $maxTimeout = inlinescript {(Get-Date).AddSeconds($using:PollingTimeoutInSeconds)} 
            $doLoop = $true
            while($doLoop) {
                  Start-Sleep -s $PollingIntervalInSeconds
                  $VMStatus = Get-AzureVM -ServiceName $ServiceName -Name $VMName | Select-Object -ExpandProperty Status
                  if ($VMStatus -eq 'StoppedVM') {$doLoop = $false}
                  if ($maxTimeout -lt (Get-Date)){throw("Can't Stop Azure VM $VMName in specified $PollingTimeoutInSeconds Seconds, Cannot Procceed Backup!")} 
            }
            
        
            # Backup Azure VM
            
            Backup-AzureVM -serviceName $ServiceName -vmName $VMName -backupContainerName $ContainerName -backupStorageAccountName $StorageAccountName -includeDataDisks
        
            # Start Azure VM
        
            Start-AzureVM -ServiceName $ServiceName -Name $VMName    
                
        
            Checkpoint-Workflow    
                
            }


}