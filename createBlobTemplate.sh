#!/bin/bash
################################################################################
# atlassian-azure-deployment / set up azuredeploy[.parameters].json in a blob
################################################################################

export location="westeurope"
export resource_group="AtlassianTest"
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
export AZURE_STORAGE_SAS_TOKEN=`az storage container generate-sas --connection-string ${AZURE_STORAGE_CONNECTION_STRING} -n ${container_name} --permissions dlrw --expiry '2019-12-30' --output tsv`

# azcopy cp "atlassian-azure-demo/confluence/" "https://atdemoconfluenceoio.blob.core.windows.net/confluencetemplateupload/?sv=2019-02-02&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-12-30T05:45:57Z&st=2019-11-25T21:45:57Z&spr=https&sig=vCBnCdLz65dSKIDVyKWHbVmFKGO1SCmOVJqK8FaCg%2Bw%3D" --recursive=true
azcopy --source atlassian-azure-demo/confluence/ --destination https://${account_name}.blob.core.windows.net/${container_name}/'?'${AZURE_STORAGE_SAS_TOKEN}# --recursive=true 
