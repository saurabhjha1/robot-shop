#!/bin/bash

ROBOTSHOP_NAMESPACE_PROJECT_NAME="robot-shop" 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ "$1" = "start" ] ; then
    oc adm new-project robot-shop
    oc adm policy add-scc-to-user anyuid -z default -n robot-shop
    oc adm policy add-scc-to-user anyuid -z rabbitmq -n robot-shop
    oc adm policy add-scc-to-user anyuid system:serviceaccount:robot-shop:rabbitmq
    oc adm policy add-scc-to-user privileged -z rabbitmq -n robot-shop
    oc adm policy add-scc-to-user privileged -z default -n robot-shop
    helm install "robot-shop" --namespace "robot-shop"  --create-namespace ${SCRIPT_DIR}/../helm  --values ${SCRIPT_DIR}/rs.os.yaml

elif [ "$1" = "stop" ] ; then
    oc delete rabbitmqclusters --all -n robot-shop
    oc delete svc -n robot-shop rabbitmq rabbitmq-nodes
    oc delete statefulset -n robot-shop rabbitmq-server
    helm uninstall "robot-shop" --namespace "robot-shop" 
    oc delete project robot-shop
fi
