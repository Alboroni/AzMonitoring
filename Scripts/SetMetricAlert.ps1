param (
 [Parameter(Mandatory)]$subscriptionId,
 [Parameter(Mandatory)]  $resourcetype,
[Parameter(Mandatory)] $metricname,
[Parameter(Mandatory)] $Alertname, 
[Parameter(Mandatory)]  $actiongroups_id,
[Parameter(Mandatory=$false)]$operator = 'GreaterThan',
[Parameter(Mandatory=$false)]$aggregation = 'Average',
[Parameter(Mandatory=$false)]$WindowSize = '0' ,
[Parameter(Mandatory=$false)]$Frequency = '0' ,
[Parameter(Mandatory=$false)]$Severity = '2' 
 
 )

 


$criteria = New-AzMetricAlertRuleV2Criteria -MetricName $metricname  -TimeAggregation Average  -Operator GreaterThan -Threshold 0
Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = (Get-AzResource -ResourceType $resourcetype).ResourceId
If($resourceIDs){
foreach ($res in $resourceIDs)

{
   
    
    Add-AzMetricAlertRuleV2 -Name $Alertname -ResourceGroupName 'azmonitoring' -WindowSize 00:05:00 -Frequency 00:05:00 -TargetResourceId $res -Condition $criteria -ActionGroup $actiongroup -DisableRule -Severity $Severity




}


}

Else {
    Write-Output "No resources of $resourcetype found in target subscription"}



#Write-Output "##vso[task.setvariable variable=resIds;]$resourceIDs[0]"
		
    ## Creates an output variable
    
#Write-Output ("##vso[task.setvariable variable=resIds;isOutput=true]$resourceIDs[0]")

Write-Host "##vso[task.setvariable variable=resIds;]$resourceIDs"
		
    ## Creates an output variable
    
