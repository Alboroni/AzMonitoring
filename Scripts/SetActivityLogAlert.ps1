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