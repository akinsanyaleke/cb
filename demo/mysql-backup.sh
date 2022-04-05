#!/bin/sh
# Perform a db dump for postgres


# Read variables 
. ./.env
DB_DUMP_LOCAL="./db/backup/${ENV_DB_DUMP_LOCAL}"
DB_POD_NAME=$(kubectl get pod -l "app=${ENV_DB_HOST_NAME}" -o jsonpath='{.items[0].metadata.name}')

if [ $? -ne 0 ]; then
	echo "Error: Unable to obtain db container id."
	echo "Check if db is online or if you are at the correct directory."
	exit 1
fi

if [ -f "${DB_DUMP_LOCAL}" ]; then
	read -r -p "${ENV_DB_DUMP_LOCAL} exists. Do you want to overwrite it? [y/n] " response
	case "$response" in
	    [yY][eE][sS]|[yY]) ;;
	    *) exit 1 ;;
	esac
fi

kubectl exec -i -t ${DB_POD_NAME} -- sh -c "mysqldump \
					--routines \
					--protocol=tcp \
					-p${ENV_DB_ROOT_PASS} \
					--single-transaction \
					--max_allowed_packet=1024M \
					--default-character-set=utf8 ${ENV_DB_NAME} > /tmp/${ENV_DB_DUMP_LOCAL}"

kubectl cp ${DB_POD_NAME}:/tmp/${ENV_DB_DUMP_LOCAL} ./${DB_DUMP_LOCAL}