param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]  $resourcetype,
#[Parameter(Mandatory=$false)][string[]] $resourcegroups,
[Parameter(Mandatory)] $Alertname, 
[Parameter(Mandatory)]  $actiongroups_id,
[Parameter(Mandatory=$false)]$Category = 'Administrative',
[Parameter(Mandatory)]$operationName 


 )


 Function New-ActivityAlert ($altname)
 {

    Set-AzActivityLogAlert -Location 'Global' 
    -Name $altname`
    -ResourceGroupName 'azmonitoring'
    -Scope $scope
    -Action $actionGroupId
    -Condition $condition1, $condition2

 }


$condition1 = New-AzActivityLogAlertCondition -Field 'category' -Equal $Category
$condition2 = New-AzActivityLogAlertCondition -Field 'operationName' -Equal $operationName

$actionGroupId = New-AzActionGroup -ActionGroupId $actiongroups_id

Select-AzSubscription -Subscription $subscriptionId


#determine the scope for alerts
if ($resourcegroups)
{
   $rgscope = @()
   #uses format  /subscriptions/00000000-0000-0000-0000-0000-00000000/resourceGroups/ResourceGroupName" 
foreach ($rg in $resourcegroups)

{


$RGscope +=  '/subscriptions/' + $subscriptionId + '/resourceGroups/' + $rg



}

 $scope = $rgscope.ToString()

}
 
else
{
$scope = '/subscriptions/' + $subscriptionId


}


New-ActivityAlert $Alertname
