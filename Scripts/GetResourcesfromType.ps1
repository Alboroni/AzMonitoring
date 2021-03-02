param (
 [Parameter(Mandatory)]$subscriptionId,[Parameter(Mandatory)] $resourcetype

)

Write-Host $resourcetype

Select-AzSubscription -Subscription $subscriptionId

$resourceIDs = (Get-AzResource -ResourceType $resourcetype).ResourceId




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

Write-Host "the end"
