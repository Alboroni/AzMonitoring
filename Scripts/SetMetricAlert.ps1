param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]  $resourcetype,
[Parameter(Mandatory)] $metricname,
[Parameter(Mandatory)] $Alertname, 
[Parameter(Mandatory)]  $actiongroups_id,
[Parameter(Mandatory=$false)]$operator = 'GreaterThan',
[Parameter(Mandatory=$false)]$aggregation = 'Average',
[Parameter(Mandatory=$false)]$WindowSize = '00:05:00' ,
[Parameter(Mandatory=$false)]$Frequency = '00:05:00' ,
[Parameter(Mandatory=$false)]$Severity = '2' 
 
 )

 Function Add-MetricAlert
{

    Add-AzMetricAlertRuleV2 -Name $Alertname -ResourceGroupName 'azmonitoring' -WindowSize $WindowSize -Frequency $Frequency -TargetResourceId $res.ResourceId -Condition $criteria -ActionGroup $actiongroup -DisableRule -Severity $Severity

}
#Set Alert Criteria
$criteria = New-AzMetricAlertRuleV2Criteria -MetricName $metricname  -TimeAggregation $aggregation  -Operator $operator -Threshold 0
Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = Get-AzResource -ResourceType $resourcetype


If($resourceIDs){
foreach ($res in $resourceIDs)

{
  #Check if load balancer on standard SKU  
 if ($res.ResourceType -eq 'microsoft.network/loadbalancers' -and $res.Sku.Name -eq 'Basic' )
 { write-host " $res.Name is a basic SKU Load Balancer cannot set Alert"}
   
else {
    
    Add-MetricAlert
}



}


}

Else {
    Write-Output "No resources of $resourcetype found in target subscription"}



#Write-Output "##vso[task.setvariable variable=resIds;]$resourceIDs[0]"
		
    ## Creates an output variable
    
#Write-Output ("##vso[task.setvariable variable=resIds;isOutput=true]$resourceIDs[0]")

Write-Host "##vso[task.setvariable variable=resIds;]$resourceIDs"


		
    ## Creates an output variable
    
