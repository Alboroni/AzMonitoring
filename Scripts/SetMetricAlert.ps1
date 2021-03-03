param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]  $resourcetype,
[Parameter(Mandatory)] $metricname,
[Parameter(Mandatory)] $Alertname, 
[Parameter(Mandatory)]  $actiongroups_id,
[Parameter(Mandatory=$false)]$operator = 'GreaterThan',
[Parameter(Mandatory=$false)]$aggregation = 'Average',
[Parameter(Mandatory=$false)]$WindowSize = '00:15:00' ,
[Parameter(Mandatory=$false)]$Frequency = '00:15:00' ,
[Parameter(Mandatory=$false)]$Threshold= '0' ,
[Parameter(Mandatory=$false)]$Severity = '2' 
 
 )

 Function Add-MetricAlert ($alertresname)
{

    Add-AzMetricAlertRuleV2 -Name $alertresname -ResourceGroupName 'azmonitoring' -WindowSize $WindowSize -Frequency $Frequency -TargetResourceId $res.ResourceId -Condition $criteria -ActionGroup $actionGroupId  -Severity $Severity

}
#Set Alert Criteria

$criteria = New-AzMetricAlertRuleV2Criteria -MetricName $metricname  -TimeAggregation $aggregation  -Operator $operator -Threshold $Threshold

Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = Get-AzResource -ResourceType $resourcetype



$actionGroupId = New-AzActionGroup -ActionGroupId $actiongroups_id


If($resourceIDs){
foreach ($res in $resourceIDs)

{

  
    $resname = $res.ResourceName.ToString()

    Write-Host = $resname + " Setting alert"

  #Check if load balancer on standard SKU  
 if ($res.ResourceType -eq 'microsoft.network/loadbalancers' -and $res.Sku.Name -eq 'Basic' )
 { write-host " $res.Name is a basic SKU Load Balancer cannot set Alert"}
   
else {
    
    # Build Name for Alert 
  $aname = ($Alertname + $resname)


    Add-MetricAlert $aname
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
    
