ARG ENV_APP_IMAGE
ARG ENV_APP_IMAGE_TAG
FROM ${ENV_APP_IMAGE}:${ENV_APP_IMAGE_TAG}

# Variables definition and checking
ARG ENV_APP_DATA_DIR
ARG ENV_APP_DUMP_REMOTE
ARG ENV_APP_DUMP_LOCAL
ENV ENV_APP_DUMP_REMOTE ${ENV_APP_DUMP_REMOTE}
ENV ENV_APP_DUMP_LOCAL ${ENV_APP_DUMP_LOCAL}

# RUN 	test -n "${ENV_APP_DUMP_LOCAL}" && \
# 	test -n "${ENV_APP_DUMP_REMOTE}"
RUN	if [ -n "${ENV_APP_DATA_DIR}" ]; then mkdir -p "${ENV_APP_DATA_DIR}"; fi

# Add custom shell scripts (build cache) & retrieve backup files
USER 	root
RUN	mkdir /tmp/build-scripts/
COPY 	build-scripts/*		/tmp/build-scripts/

#Copying app dump from local as a remote artifactory is not available for workshop
COPY ./backup/${ENV_APP_DUMP_LOCAL} /tmp/${ENV_APP_DUMP_LOCAL}

# Run custom shell scripts
RUN 	for i in /tmp/build-scripts/*.sh ; do sh -e "$i" || exit 1; done
USER 	appuser


