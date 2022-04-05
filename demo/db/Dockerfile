ARG ENV_DB_IMAGE
ARG ENV_DB_IMAGE_TAG
FROM ${ENV_DB_IMAGE}:${ENV_DB_IMAGE_TAG}

# Variables definition and testing
ARG ENV_DB_DATA_DIR
ARG ENV_DB_DUMP_REMOTE
ARG ENV_DB_DUMP_LOCAL
ENV ENV_DB_DATA_DIR ${ENV_DB_DATA_DIR}

#Commenting test as a remote artifactory is not available for workshop
#RUN	test -n "${ENV_DB_DUMP_REMOTE}" && \
#	test -n "${ENV_DB_DUMP_LOCAL}"
RUN     if [ -n "${ENV_DB_DATA_DIR}" ]; then mkdir -p "${ENV_DB_DATA_DIR}"; fi

# Retrieve and restore backup
#COPY	init-scripts/*		/docker-entrypoint-initdb.d

#Commenting download from remote as artifactory is not available for workshop
#ADD	${ENV_DB_DUMP_REMOTE} /docker-entrypoint-initdb.d/${ENV_DB_DUMP_LOCAL}

#Copying app dump from local as a remote artifactory is not available for workshop
COPY ./backup/${ENV_DB_DUMP_LOCAL} /docker-entrypoint-initdb.d/${ENV_DB_DUMP_LOCAL}

RUN	chmod -R 755 /docker-entrypoint-initdb.d/*

# Workaround for healthcheck false positive
RUN	if [ -f "${MARKER_FILE}" ]; then rm -f "${MARKER_FILE}"; fi

# Workaround for no ARG substitution in CMD
ENTRYPOINT env.sh mysqld --datadir "${ENV_DB_DATA_DIR}"
