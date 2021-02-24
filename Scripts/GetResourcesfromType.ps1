param (
 [Parameter(Mandatory)]$subscriptionId,[Parameter(Mandatory)] $resourcetype

)

Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = (Get-AzResource -ResourceType $resourcetype).ResourceId




Write-Output "##vso[task.setvariable variable=resourceIds;]$resourceIDs"
		
    ## Creates an output variable
    
Write-Output "##vso[task.setvariable variable=resourceIds;isOutput=true ]$resourceIDs"

Write-Host $resourceIDs