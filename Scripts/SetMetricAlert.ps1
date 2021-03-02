param (
 [Parameter(Mandatory)]$subscriptionId,
 [Parameter(Mandatory)]  $resourcetype,
[Parameter(Mandatory)] $metricname,
[Parameter(Mandatory)] $Alertname, 
[Parameter(Mandatory)]  $actiongroups_id,
$operator = 'GreaterThan',
$aggregation = 'Average',
$Threshold = '0' 
 
 )

 


$criteria = New-AzMetricAlertRuleV2Criteria -MetricName $metricname  -TimeAggregation $aggregation  -Operator $operator -Threshold $Threshold
Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = (Get-AzResource -ResourceType $resourcetype).ResourceId

foreach ($res in $resourceIDs)

{
   
    
    Add-AzMetricAlertRuleV2 -Name $Alertname -ResourceGroupName 'azmonitoring' -WindowSize 00:05:00 -Frequency 00:05:00 -TargetResourceId $res -Condition $criteria -ActionGroup $actiongroup -DisableRule -Severity 4




}




Write-Output "##vso[task.setvariable variable=resIds;]$resourceIDs[0]"
		
    ## Creates an output variable
    
Write-Output ("##vso[task.setvariable variable=resIds;isOutput=true]$resourceIDs[0]")

Write-Host "##vso[task.setvariable variable=resIds;]$resourceIDs"
		
    ## Creates an output variable
    
Write-Host "##vso[task.setvariable variable=resIds;isOutput=true ]$resourceIDs"

Write-Output "##vso[task.setvariable variable=testvar;isOutput=true]testvalue"

Write-Output  ("##vso[task.setvariable variable=testvar1;isOutput=true]testvalue")


#Write-Host $resourceIDs


Write-Host " output 1 is $env:testvar"
Write-Host " output 2 is $env:testvar1"

write-host $(testvar)
Write-Host $(testvar1)

Write-Host $testvar1
