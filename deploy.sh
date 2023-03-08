#!/bin/bash

ROBOTSHOP_NAMESPACE_PROJECT_NAME="robot-shop" 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ "$1" = "start" ] ; then
    helm install "${ROBOTSHOP_NAMESPACE_PROJECT_NAME}" --namespace "${ROBOTSHOP_NAMESPACE_PROJECT_NAME}"  --create-namespace K8s/helm 
elif [ "$1" = "stop" ] ; then
    helm uninstall "${ROBOTSHOP_NAMESPACE_PROJECT_NAME}" --namespace "${ROBOTSHOP_NAMESPACE_PROJECT_NAME}" 
fi