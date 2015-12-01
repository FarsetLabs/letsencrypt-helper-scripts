#!/usr/bin/env bash
export DOMAIN="blog.farsetlabs.org.uk"
export ROOT="/home/farsetlabs/domains/${DOMAIN}"
export IMAGE="quay.io/letsencrypt/letsencrypt:latest"
docker pull ${IMAGE}
docker run -it --rm --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -v "${ROOT}:${ROOT}" \
    ${IMAGE} certonly \
    --server https://acme-v01.api.letsencrypt.org/directory --email "services@farsetlabs.org.uk" \
    -a webroot --webroot-path="${ROOT}/public_html" --renew-by-default --agree-dev-preview --agree-tos -d ${DOMAIN} --text $@
ln -sf "/etc/letsencrypt/live/${DOMAIN}/cert.pem" "${ROOT}/ssl.cert"
ln -sf "/etc/letsencrypt/live/${DOMAIN}/privkey.pem" "${ROOT}/ssl.key"
ln -sf "/etc/letsencrypt/live/${DOMAIN}/chain.pem" "${ROOT}/ssl.ca"
