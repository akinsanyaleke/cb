#!/bin/bash

DIR="https://raw.githubusercontent.com/akinsanyaleke/cb/main/resources"

kubectl apply -f $DIR/workshop.yaml 2>/dev/null
kubectl apply -f $DIR/training-portal.yaml 2>/dev/null
