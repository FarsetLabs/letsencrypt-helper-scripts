#!/usr/bin/env bash
export DOMAINS="-d discourse.farsetlabs.org.uk"
export IMAGE="quay.io/letsencrypt/letsencrypt:latest"
docker pull ${IMAGE}
/var/discourse/launcher stop app
docker run -it --rm --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
    -p 80:80 -p 443:443 \
    ${IMAGE} certonly \
    --email "services@farsetlabs.org.uk" \
    --renew-by-default --agree-tos ${DOMAINS} --text $@
/var/discourse/launcher start app
