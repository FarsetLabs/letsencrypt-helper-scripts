#!/usr/bin/env bash
export DOMAINS="-d farsetlabs.org.uk -d beta.farsetlabs.org.uk -d assets.farsetlabs.org.uk"
export DIR=/tmp/letsencrypt-auto
export IMAGE="quay.io/letsencrypt/letsencrypt:latest"
docker pull ${IMAGE}
docker run -it --rm --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -v "${DIR}:${DIR}" \
    ${IMAGE} certonly \
    --email "services@farsetlabs.org.uk" \
    -a webroot --webroot-path=${DIR} --renew-by-default --agree-tos ${DOMAINS} --text $@
