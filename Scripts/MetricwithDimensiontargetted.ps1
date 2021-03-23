param (
[Parameter(Mandatory)]$subscriptionId,
[Parameter(Mandatory)]$resourcegroup,
[Parameter(Mandatory)]$resourcetype,
[Parameter(Mandatory=$false)]$resourcename,
[Parameter(Mandatory)]$metricname,
[Parameter(Mandatory)]$Alertname, 
[Parameter(Mandatory)]$actiongroups_id,
[Parameter(Mandatory=$false)]$Operator = 'GreaterThan',
[Parameter(Mandatory=$false)]$Aggregation = 'Average',
[Parameter(Mandatory=$false)]$WindowSize = '00:15:00' ,
[Parameter(Mandatory=$false)]$Frequency = '00:05:00' ,
[Parameter(Mandatory=$false)]$Threshold= '0' ,
[Parameter(Mandatory=$false)]$Dim1Name= '0' ,
[Parameter(Mandatory=$false)]$Dim1Value= '0' ,
[Parameter(Mandatory=$false)]$Dim2Name ,
[Parameter(Mandatory=$false)]$Dim2Value ,
[Parameter(Mandatory=$false)]$Severity = '2' 

 
 )

 Function Add-MetricAlert ($alertresname)
{
If($Dim1Name -and $Dim2Name)
    {
        $dim1 = New-AzMetricAlertRuleV2DimensionSelection  -DimensionName $Dim1Name -ValuesToInclude $Dim1Value

        $dim2 = New-AzMetricAlertRuleV2DimensionSelection  -DimensionName $Dim2Name -ValuesToInclude $Dim2Value

        $criteria = New-AzMetricAlertRuleV2Criteria -MetricName $metricname -DimensionSelection $dim1,$dim2   -TimeAggregation $aggregation  -Operator $operator -Threshold $Threshold
        
        Add-AzMetricAlertRuleV2 -Name $alertresname -ResourceGroupName  $resourcegroup -WindowSize $WindowSize -Frequency $Frequency -TargetResourceId $res.ResourceId -Condition $criteria -ActionGroup $actionGroupId  -Severity $Severity}

}

If ($Dim1Name -and !$Dim2Name)

{
    $dim1 = New-AzMetricAlertRuleV2DimensionSelection  -DimensionName $Dim1Name -ValuesToInclude $Dim1Value

    $criteria = New-AzMetricAlertRuleV2Criteria -MetricName $metricname -DimensionSelection $dim1,$dim2   -TimeAggregation $aggregation  -Operator $operator -Threshold $Threshold

    Add-AzMetricAlertRuleV2 -Name $alertresname -ResourceGroupName  $resourcegroup -WindowSize $WindowSize -Frequency $Frequency -TargetResourceId $res.ResourceId -Condition $criteria -ActionGroup $actionGroupId  -Severity $Severity



}
#Set Alert Criteria


Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId
if($resourcename)
{$resourceIDs = Get-AzResource -ResourceType $resourcetype -Name $resourcename}

else {
    $resourceIDs = Get-AzResource -ResourceType $resourcetype

}



$actionGroupId = New-AzActionGroup -ActionGroupId $actiongroups_id


If($resourceIDs){
foreach ($res in $resourceIDs)

{

  
    $resname = $res.ResourceName.ToString()

    Write-Host = $resname + " Setting alert"


    Switch ($res.ResourceType) 
    {
       'microsoft.automation/automationaccounts' {   
   
   
   if ($resourcename -and ($Dim1Value -ne '*')) 
   {
      $runbook = Get-AzAutomationRunbook -ResourceGroupName $res.ResourceGroupName -AutomationAccountName $resourcename -Name $Dim1Value
 write-Host  " $Dim1value runbook found setting alerts on $resname Autoccount"
if($runbook) {
 $aname = ($Alertname + $resname)
 Add-MetricAlert $aname
}
else {

    write-Host   "$Dim1value not runbook found setting not setting alerts on $resname Autoccount"

}
   }
   elseif ($resourcename -and ($Dim1Value -eq '*')) {


$aname = ($Alertname + $resname)
 Add-MetricAlert $aname

       
   } 
   
   
   else {

    if($Dim1Value -eq '*'){



        $aname = ($Alertname + $resname)
        Add-MetricAlert $aname


    }

else{
    write-host "Please set resourcename parameter if setting Automation account runbook metric alert without wildcard"


}

       } 

   
   
   
   
   
   
    

    'microsoft.network/loadbalancers' {
        if ($res.ResourceType -eq 'microsoft.network/loadbalancers' -and $res.Sku.Name -eq 'Basic' )
        { write-host " $res.Name is a basic SKU Load Balancer cannot set Alert"}
          
       else {
           
           # Build Name for Alert 
         $aname = ($Alertname + $resname)
       
       
           Add-MetricAlert $aname
       }

    }

    default { $aname = ($Alertname + $resname)
       
       
        Add-MetricAlert $aname}

    }
  #Check if load balancer on standard SKU  




}


}

Else {
    Write-Output "No resources of $resourcetype found in target subscription"}



#Write-Output "##vso[task.setvariable variable=resIds;]$resourceIDs[0]"
		
    ## Creates an output variable
    
#Write-Output ("##vso[task.setvariable variable=resIds;isOutput=true]$resourceIDs[0]")

Write-Host "##vso[task.setvariable variable=resIds;]$resourceIDs"


		
    ## Creates an output variable
    
