#!/bin/bash
################################################################################
# atlassian-azure-deployment / set up azuredeploy[.parameters].json in a blob
################################################################################

export location="westeurope"
export resource_group="atdemo-confluence-blob"
export account_name="atdemoconfluenceoio"
export account_sku="Standard_LRS"
export container_name="confluencetemplateupload"

# az login

az group create                        \
    --location ${location}             \
    --resource-group ${resource_group}

az storage account create              \
    --location ${location}             \
    --name ${account_name}             \
    --resource-group ${resource_group} \
    --sku ${account_sku}

export AZURE_STORAGE_CONNECTION_STRING=`az storage account show-connection-string --name ${account_name} --resource-group ${resource_group} --output tsv`

az storage container create  --connection-string ${AZURE_STORAGE_CONNECTION_STRING} --name ${container_name}

export AZURE_STORAGE_ACCOUNT=${account_name}
export AZURE_STORAGE_SAS_TOKEN=`az storage container generate-sas --connection-string ${AZURE_STORAGE_CONNECTION_STRING} -n ${container_name} --permissions rl --expiry '2019-05-30' --output tsv`

azcopy --source atlassian-azure-deployment/confluence/ --destination https://${account_name}.blob.core.windows.net/${container_name}/ --recursive --dest-sas ${AZURE_STORAGE_SAS_TOKEN}
