params (
 [Parameter(Mandatory)]$subscriptionId,[Parameter(Mandatory)] $resourcetype

)

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = (Get-AzResource -ResourceType $resourcetype).Id


Write-Output "##vso[task.setvariable variable=$resIds;]$resourceIDs"
		
    ## Creates an output variable
    
Write-Output "##vso[task.setvariable variable=$resIds;isOutput=true]$resourceIDs"

