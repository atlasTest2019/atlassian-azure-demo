#!/bin/bash
################################################################################
# atlassian-azure-deployment / deploy jira on azure
################################################################################
export location="westeurope"
export resource_group="AtlassianTest"
export account_name="atdemoconfluenceoio"
export account_sku="Standard_LRS"
export container_name="confluencete"


az group create                        \
    --location ${location}             \
    --resource-group ${resource_group}
az group deployment create --resource-group ${resource_group} --template-file azuredeploy.json --parameters azuredeploy.parameters.json
