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

 $scope = New-Object System.Collections.Generic.List[System.String]


 Function New-ActivityAlert ($altname, $scope)
 {

 write-host "setting Alert $altname in $resourcegroup" 
 write-host "the conditions are $category  and $operationNAme and $status "


   Set-AzActivityLogAlert -Location 'Global'  -Name $altname -ResourceGroupName  $resourcegroup -Scope $scope -Action $actionGroupId -Condition $condition1, $condition2, $condition3 -Description "$altname has fired. Please check the Azure Activity log associated with the resource for further details" 


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
   
   
  $outItems = New-Object System.Collections.Generic.List[System.String]
  $resarray=  $targetresourcegroup.split(",")

foreach ($res in $resarray){
 #uses format  /subscriptions/00000000-0000-0000-0000-0000-00000000/resourceGroups/ResourceGroupName" 
$newscope = "/subscriptions/$sub/ResourceGroups/$res"
$outItems.add($newscope)


}


$scope = $outItems
$altname =$alertname + '-' + $sub.Name + 'RGScope'

}
 
else
{
$scope.add("/subscriptions/$sub")
$altname = $alertname + '-' + $sub.Name

}


New-ActivityAlert $altname $scope
