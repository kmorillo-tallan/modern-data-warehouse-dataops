#!/usr/bin/env bash
export TENANT_ID="b7c4d562-d8f6-47ee-bab9-b9ee602bc6f0"

echo "Configure az devops cli"
az devops configure --defaults organization="$AZDO_ORGANIZATION_URL" project="$AZDO_PROJECT"

echo "Install requirements depending if devcontainer was openned at root or in parking_sensor folder."

{ # try
    az account show --output table
    echo 
} || { # catch
    # Assume opened at 'PARKING_SENSORS' folder, the below should work
    pip install -r ./src/ddo_transform/requirements_dev.txt
    az login --tenant $TENANT_ID
    az account list --output table
}
echo 

az account set -n 'VS - Morillo'
az account show --output table

echo 
## az config set defaults.location=westus2 defaults.group=MyResourceGroup
az group list --output table

echo

AZURE_LOCATION=westus

./deploy.sh






