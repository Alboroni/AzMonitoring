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
New-AzDataCollectionRuleAssociation -TargetResourceId $vmdcr.Id -AssociationName "dcrwindowsAssoc" -RuleId $DCRWindows_ID
}

if ($OsType -eq 'Linux')  {

    Write-Host "Creating Association Host $vmd -TargetResourceId $vmdcr.Id -AssociationName "dcrwlinuxAssoc" -RuleId $DCRLinux_ID"
    New-AzDataCollectionRuleAssociation -TargetResourceId $vmdcr.Id -AssociationName "dcrwlinuxAssoc" -RuleId $DCRLinux_ID 

}

}

