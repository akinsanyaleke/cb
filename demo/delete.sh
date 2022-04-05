#!/bin/sh
# Perform 

# Read variables 
. ./.env
ytt -f ./manifest-files --data-values-env ENV | kubectl delete -f-