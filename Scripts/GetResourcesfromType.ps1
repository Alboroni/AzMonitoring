param (
 [Parameter(Mandatory)]$subscriptionId,[Parameter(Mandatory)] $resourcetype

)

Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = (Get-AzResource -ResourceType $resourcetype).ResourceId




Write-Output "##vso[task.setvariable variable=resIds;]$resourceIDs"
		
    ## Creates an output variable
    
Write-Output "##vso[task.setvariable variable=resIds;isOutput=true ]$resourceIDs"

Write-Host "##vso[task.setvariable variable=resIds;]$resourceIDs"
		
    ## Creates an output variable
    
Write-Host "##vso[task.setvariable variable=resIds;isOutput=true ]$resourceIDs"

Write-Host "##vso[task.setvariable variable=testvar;]testvalue"

#Write-Host $resourceIDs


write-host $env:testvar

Write-Host "the end"
