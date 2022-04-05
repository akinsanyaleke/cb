#!/bin/bash

if [[ -z "${LC_DTAP}" ]]; then
  DTAP="staging"
else
  DTAP="${LC_DTAP}"
fi

echo "INFO: DTAP is $DTAP"

if [ "$DTAP" != "prod" ]; then
  OBJ="spring-cloud-gateway-for-kubernetes-$DTAP"
else
  # don't want -prod on it, just cleaner
  OBJ="spring-cloud-gateway-for-kubernetes"
fi

echo "INFO: removing workshops..."
if kubectl get workshops.learningcenter.tanzu.vmware.com $OBJ 2>/dev/null; then
  kubectl delete workshops.learningcenter.tanzu.vmware.com $OBJ
fi

if [ "$DTAP" != "prod" ]; then
  OBJ="spring-cloud-gateway-$DTAP"
else
  # don't want -prod on it, just cleaner
  OBJ="spring-cloud-gateway"
fi

echo "INFO: removing trainingportals..."
if kubectl get trainingportals.learningcenter.tanzu.vmware.com $OBJ 2>/dev/null; then
  kubectl delete trainingportals.learningcenter.tanzu.vmware.com $OBJ
fi

echo "INFO: checking namespace..."
until ! kubectl get ns $OBJ-ui 2>/dev/null; do
  echo "sleeping waiting for ns to delete"
  sleep 2
done

echo "INFO: creating $OBJ environment"

BASE_URL="https://raw.githubusercontent.com/ccollicutt/spring-cloud-gateway-learning-center/main/resources/"

echo "INFO: creating workshop..."
kubectl apply -f $BASE_URL/workshop-$DTAP.yaml 2>/dev/null
echo "INFO: creating training portal..."
kubectl apply -f $BASE_URL/training-portal-$DTAP.yaml 2>/dev/null