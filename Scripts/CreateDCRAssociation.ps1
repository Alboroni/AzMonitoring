param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]$resourcegroup,
[Parameter(Mandatory=$false)]$TargetRG, 
[Parameter(Mandatory)] $DCRWindows_ID,
[Parameter(Mandatory= $false)] $DCRLinux_ID,
[Parameter(Mandatory=$false)] $linux



 )

 if ($targetRG)
{
$vmsdcr = get-azVM -ResourceGroupName $TargrtRG
}

else {

$vmsdcr = Get-azVM

}



foreach ($vmdcr in $vmsdcr)
{

 If ($vmdcr.OsType -eq 'Windows')   
{ 

    Write-Host "Creating Association Host $vmdcr.Name "
New-AzDataCollectionRuleAssociation -TargetResourceId $vmdcr.Id -AssociationName "dcrwindowsAssoc" -RuleId $DCRWindows_ID
}

if ($vmdcr.OsType -eq 'Linux')  {

    Write-Host "Creating Association Host $vmdcr.Name "
    New-AzDataCollectionRuleAssociation -TargetResourceId $vmdcr.Id -AssociationName "dcrwlinuxAssoc" -RuleId $DCRLinux_ID

}

}

