## AzMonitoring

**Repository for Automatically Deploying Monitoring**

The repository contains artifacts that can be use to deploy alerting across environments. Alerts are deployed via ARM templates or Scripts dependent on the requirement. 

## Resource Health Alerts 

Base template will deploy resource health alerts for all resources in targeted subscription. The criteria is defined in the template without parameters. <br>
**Criteria** <br>
 Severity = Critical <br>
 Platform Initiated <br>
 Health Status = Degraded or Unavailable

 ## Metric Alerts  

 Metric alerts can deploy in two ways via script or template. For Resource Types that support multi resource targetting we use a tempalte with parameter file and for all other resources we use a script to deploy the metric alerts

**Multi-Resource Metric Alerts**

  Resource Types Currently supported **Virtual Machine**, **Key Vault**. **SQL server databases**, **SQL server elastic pools** and **NetApp files volumes**. 

  We have a base template for each resource type and then a parameter file for each metric we want to alerts on for resource type. The alerts will be scoped to  subscription so all resources of targetted type will alert to defined thresholds

**Single Criteria Metric Alert**

For alerts that do no support scoped targetting 









 

