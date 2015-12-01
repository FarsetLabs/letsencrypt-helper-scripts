#!/usr/bin/env bash
export DOMAINS="-d beta.farsetlabs.org.uk -d assets.farsetlabs.org.uk"
export DIR=/tmp/letsencrypt-auto
docker run -it --rm --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -v "${DIR}:${DIR}" \
    quay.io/letsencrypt/letsencrypt:latest certonly \
    --server https://acme-v01.api.letsencrypt.org/directory \
    -a webroot --webroot-path=${DIR} --agree-dev-preview ${DOMAINS}