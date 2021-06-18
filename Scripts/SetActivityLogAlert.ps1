param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]$resourcegroup,
[Parameter(Mandatory=$false)] $resourcetype,
[Parameter(Mandatory=$false)]$targetresourcegroup,
[Parameter(Mandatory)]$Alertname, 
[Parameter(Mandatory)] $actiongroups_id,
[Parameter(Mandatory=$false)]$Category = 'Administrative',
[Parameter(Mandatory)]$operationName ,
[Parameter(Mandatory=$false)]$status = 'Succeeded'



 )


 Function New-ActivityAlert ($altname, $scope)
 {

    Set-AzActivityLogAlert -Location 'Global'  -Name $altname -ResourceGroupName  $resourcegroup -Scope $scope  -Action $actionGroupId -Condition $condition1, $condition2, $condition3



 }


$condition1 = New-AzActivityLogAlertCondition -Field 'category' -Equal $Category
$condition2 = New-AzActivityLogAlertCondition -Field 'operationName' -Equal $operationName
$condition3 = New-AzActivityLogAlertCondition -Field 'status' -Equal $status

$actionGroupId = New-AzActionGroup -ActionGroupId $actiongroups_id

Select-AzSubscription -Subscription $subscriptionId

$sub = Get-AzSubscription -SubscriptionId $subscriptionId


#determine the scope for alerts
if ($targetresourcegroup)
{
   $outItems = New-Object System.Collections.Generic.List[System.Object]
  $resarray=  $targetresourcegroup.split(",")

  foreach ($res in $resarray){
 #uses format  /subscriptions/00000000-0000-0000-0000-0000-00000000/resourceGroups/ResourceGroupName" 
$newscope = "/subscriptions/$sub/ResourceGroups/$res" ;
$outItems.add($newscope)

}

$stringout = $outItems|%{[string]$_}

$prescope= $stringout -join "','"

$scope = "'" + $prescope.ToString() + "'"

Write-host  "$scope" + Scope

$altname =$alertname + '-' + $sub.Name

}
 
else
{
$scope = "/subscriptions/$sub"
$altname = $alertname + '-' + $sub.Name

}


New-ActivityAlert $altname $scope
