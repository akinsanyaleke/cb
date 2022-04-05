#!/bin/sh
# Perform 

# Read variables 
. ./.env

APP_DUMP_LOCAL="./app/backup/${ENV_APP_DUMP_LOCAL}"
APP_POD_NAME=$(kubectl get pod -l "app=${ENV_APP_NAME_CUSTOM}" -o jsonpath='{.items[0].metadata.name}')
if [ $? -ne 0 ]; then
	echo "Error: Unable to obtain pod name."
	echo "Check if db is online or if you are at the correct directory."
	exit 1
fi

if [ -f "${APP_DUMP_LOCAL}" ]; then
	read -r -p "${ENV_APP_DUMP_LOCAL} exists. Do you want to overwrite it? [y/n] " response
	case "$response" in
	    [yY][eE][sS]|[yY]) ;;
	    *) exit 1 ;;
	esac
fi

kubectl exec -i -t ${APP_POD_NAME} -- sh -c "tar czf /tmp/backup-${ENV_APP_DUMP_LOCAL} -C ${ENV_APP_DATA_DIR} ."
kubectl cp ${APP_POD_NAME}:/tmp/backup-${ENV_APP_DUMP_LOCAL} ${APP_DUMP_LOCAL}