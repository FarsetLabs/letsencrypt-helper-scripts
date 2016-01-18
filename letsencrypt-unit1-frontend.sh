#!/usr/bin/env bash
export DOMAINS="-d farsetlabs.org.uk -d auth.farsetlabs.org.uk -d build.farsetlabs.org.uk -d code.farsetlabs.org.uk -d discourse.farsetlabs.org.uk -d docs.farsetlabs.org.uk -d issues.farsetlabs.org.uk -d storage.farsetlabs.org.uk -d virtualmin.farsetlabs.org.uk -d voip.farsetlabs.org.uk -d wifi.farsetlabs.org.uk -d wiki.farsetlabs.org.uk"
export DIR=/tmp/letsencrypt-auto
export IMAGE="quay.io/letsencrypt/letsencrypt:latest"
docker pull ${IMAGE}
docker run -it --rm --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -v "${DIR}:${DIR}" \
    ${IMAGE} certonly \
    --email "services@farsetlabs.org.uk" \
    -a webroot --webroot-path=${DIR} --renew-by-default --agree-tos ${DOMAINS} --text $@
