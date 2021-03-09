param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]  $resourcetype,
#if targetting RGs (
[Parameter(Mandatory=$false)] $resourcegroups,
[Parameter(Mandatory)] $Alertname, 
[Parameter(Mandatory)]  $actiongroups_id,
[Parameter(Mandatory=$false)]$Category = 'Administrative',
[Parameter(Mandatory)]$operationname 


 )


 Function New-ActivityAlert ($altname)
 {

    Set-AzActivityLogAlert -Location 'Global' `
    -Name $altname`
    -ResourceGroupName 'azmonitoring'
    -Scope $scope
    -Action $actionGroupId
    -Condition $condition1, $condition2

 }


 $condition1 = New-AzActivityLogAlertCondition -Field 'category' -Equal $Category
$condition2 = New-AzActivityLogAlertCondition -Field 'operationName' -Equal $operationname

$actionGroupId = New-AzActionGroup -ActionGroupId $actiongroups_id

Select-AzSubscription -Subscription $subscriptionId


#determine the scope for alerts
if ($resourcegroups)
{

   #uses format  /subscriptions/00000000-0000-0000-0000-0000-00000000/resourceGroups/ResourceGroupName" 

$scope =  '/subscriptions/' + $subscriptionId + '/resourceGroups/' + $resourcegroups



}
 
else
{
$scope = '/subscriptions/' + $subscriptionId


}