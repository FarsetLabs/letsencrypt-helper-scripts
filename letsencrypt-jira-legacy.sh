#!/usr/bin/env bash
export DOMAINS="-d jira.farsetlabs.org.uk"
export DIR=/tmp/letsencrypt-auto
export IMAGE="quay.io/letsencrypt/letsencrypt:latest"
docker pull ${IMAGE}
service nginx stop
docker run -it --rm --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -v "${DIR}:${DIR}" -p 80:80 -p 443:443 \
    ${IMAGE} certonly \
    --server https://acme-v01.api.letsencrypt.org/directory \
    --agree-dev-preview ${DOMAINS} --text $@
service nginx start
