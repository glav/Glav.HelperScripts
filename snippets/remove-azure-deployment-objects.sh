#!/bin/bash

while getopts n: option
do
case "${option}"
in
n) rg=${OPTARG};;
esac
done


echo ""
echo "Remove Azure Deployment objects."
echo "Note: You need to be logged in for this to work"
echo ""

if [ -z "$rg" ]
then
    echo "Must supply a resource group name -n {resource-group-name}"
    exit
fi

echo "Removing deployment objects from resource group: $rg"

echo "Getting Deployments..."
deploys=$(az group deployment list -g $rg --query [].name --output tsv)
for d in $deploys
do
    echo "..Removing deployment object: '$d'"
    az group deployment delete -g $rg -n $d
done
echo "Done."

