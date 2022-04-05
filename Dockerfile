FROM quay.io/eduk8s/base-environment:master

USER root

# Knative
# RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.2.0/kn-linux-amd64 && \
#     chmod 755 /usr/local/bin/kn

# USER 1001

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s



