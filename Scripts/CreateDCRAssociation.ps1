param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]$resourcegroup,
[Parameter(Mandatory=$false)]$TargetRG, 
[Parameter(Mandatory)] $DCRWindows_ID,
[Parameter(Mandatory= $false)] $DCRLinux_ID,
[Parameter(Mandatory=$false)] $linux


 )

Write-Host "here we go" 

 if ($targetRG)
{

$vmsdcr = get-azVM -ResourceGroupName $TargetRG
}

else {
Write-HOst "Getting VMs"
$vmsdcr = Get-azVM

}



foreach ($vmdcr in $vmsdcr)
{
 Write-host "$vmdcr.Name "
$OSType = $vmdcr.StorageProfile.OsDisk.OsType

 #New-AzDataCollectionRuleAssociation -TargetResourceId $vmdcr.Id -AssociationName "dcrwlinuxAssoc" -RuleId $DCRLinux_ID


 If ($OsType -eq 'Windows')   
{ 

    Write-Host "Creating Association Host $vmdcr.Name "
    
   $VMExt=  Get-AzVMExtension -ResourceGroupName $vmdcr.ResourceGroupName -VMName $vmdcr.Name -Name "AzureMonitorWindowsAgent"

 if (!$VMExt)   

{Set-AzVMExtension -Name AMAWindows -ExtensionType AzureMonitorWindowsAgent -Publisher Microsoft.Azure.Monitor -ResourceGroupName $vmdcr.ResourceGroupName -VMName $vmdcr.Name> -Location $vmdcr.Location -TypeHandlerVersion 1.0
}
New-AzDataCollectionRuleAssociation -TargetResourceId $vmdcr.Id -AssociationName "dcrwindowsAssoc" -RuleId $DCRWindows_ID
}

if ($OsType -eq 'Linux')  {

    $VMExt=  Get-AzVMExtension -ResourceGroupName $vmdcr.ResourceGroupName -VMName $vmdcr.Name -Name "AzureMonitorLinuxAgent"

    if (!$VMExt)   
   
   {Set-AzVMExtension -Name AMALinux -ExtensionType AzureMonitorLinuxAgent -Publisher Microsoft.Azure.Monitor -ResourceGroupName $vmdcr.ResourceGroupName -VMName $vmdcr.Name> -Location $vmdcr.Location -TypeHandlerVersion 1.0
   }

    Write-Host "Creating Association Host $vmd -TargetResourceId $vmdcr.Id -AssociationName "dcrwlinuxAssoc" -RuleId $DCRLinux_ID"
    New-AzDataCollectionRuleAssociation -TargetResourceId $vmdcr.Id -AssociationName "dcrwlinuxAssoc" -RuleId $DCRLinux_ID 

}

}

