param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]$resourcegroup,
[Parameter(Mandatory=$false)] $resourcetype,
[Parameter(Mandatory=$false)]$targetresourcegroup,
[Parameter(Mandatory)] $Alertname, 
[Parameter(Mandatory)]  $actiongroups_id,
[Parameter(Mandatory=$false)]$Category = 'Administrative',
[Parameter(Mandatory)]$operationName 


 )


 Function New-ActivityAlert ($altname)
 {

    Set-AzActivityLogAlert -Location 'Global'  -Name $altname -ResourceGroupName  $resourcegroup -Scope $scope -Action $actionGroupId -Condition $condition1, $condition2



 }


$condition1 = New-AzActivityLogAlertCondition -Field 'category' -Equal $Category
$condition2 = New-AzActivityLogAlertCondition -Field 'operationName' -Equal $operationName

$actionGroupId = New-AzActionGroup -ActionGroupId $actiongroups_id

Select-AzSubscription -Subscription $subscriptionId

$sub = Get-AzSubscription -SubscriptionId $subscriptionId


#determine the scope for alerts
if ($targetresourcegroup)
{
   
 #uses format  /subscriptions/00000000-0000-0000-0000-0000-00000000/resourceGroups/ResourceGroupName" 
$scope = "/subscriptions/$sub/ResourceGroups/$targetresourcegroup" 
$altname =$alertname + '-' + $targetresourcegroup

}
 
else
{
$scope = "/subscriptions/$sub"
$altname = $alertname + '-' + $sub.Name

}


New-ActivityAlert $altname
