workflow Call-AzureChildRunbook
{

    $Cred = Get-AutomationPSCredential -Name "automationadmin@shzhailab.partner.onmschina.cn"
    
    Start-AutomationChildRunbook -AutomationAccountName 'shzhaiautomationaccount' `
    -AzureOrgIdCredential $Cred `
    -AzureSubscriptionName 'Windows Azure Internal Consumption' `
    -ChildRunbookName Write-HelloWorld `
    -ChildRunbookInputParams @{"Name" = "Shawn"} `
    -JobPollingIntervalInSeconds 10 `
    -JobPollingTimeoutInSeconds 600 `
    -ReturnJobOutput $True `
    -WaitForJobCompletion $True

    <# 
    $Cred = Get-AutomationPSCredential -Name "automationadmin@shzhailab.partner.onmschina.cn"
  
    $Params = @{
        "AutomationAccountName" = "shzhaiautomationaccount";
        "AzureOrgIdCredential" = $Cred;
        "AzureSubscriptionName" = "Windows Azure Internal Consumption";
        "ChildRunbookName" = "Write-HelloWorld";
        "ChildRunbookInputParams" = @{"Name" = "Shawn"};
        "JobPollingIntervalInSeconds" = 10;
        "JobPollingTimeoutInSeconds" = 600;
        "ReturnJobOutput" = $True;
        "WaitForJobCompletion" = $True
        } 
   
    Start-AutomationChildRunbook @Params
     #>
         
}