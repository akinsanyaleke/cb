#!/bin/bash

OBJ="spring-cloud-gateway-for-kubernetes"

echo "INFO: removing workshops..."
if [ "$(kubectl get workshops.learningcenter.tanzu.vmware.com 2>/dev/null | grep $OBJ | wc -l)" -gt "0" ]; then
  kubectl delete workshops.learningcenter.tanzu.vmware.com $OBJ
fi

OBJ="spring-cloud-gateway"

echo "INFO: removing trainingportals..."
if [ "$(kubectl get trainingportals.learningcenter.tanzu.vmware.com 2>/dev/null | grep $OBJ | wc -l)" -gt "0" ]; then
  kubectl delete trainingportals.learningcenter.tanzu.vmware.com $OBJ
fi

echo "INFO: checking namespace..."
while [ "$(kubectl get ns 2>/dev/null | grep $OBJ | wc -l)" -nt "0" ]; do
  echo "sleeping waiting for ns to delete"
  sleep 2
done