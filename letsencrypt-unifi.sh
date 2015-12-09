#!/usr/bin/env bash
export DOMAIN="wifi.farsetlabs.org.uk"
export IMAGE="quay.io/letsencrypt/letsencrypt:latest"
docker pull ${IMAGE}
service unifi stop
docker run -it --rm --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -p 80:80 -p 443:443 \
    ${IMAGE} certonly \
    --email "services@farsetlabs.org.uk" \
    --renew-by-default --agree-tos -d ${DOMAIN} --text $@
openssl pkcs12 -export \
    -in /etc/letsencrypt/live/${DOMAIN}/cert.pem \
    -inkey /etc/letsencrypt/live/${DOMAIN}/privkey.pem \
    -out unifi.p12 -name unifi \
    -CAfile /etc/letsencrypt/live/${DOMAIN}/chain.pem -caname root
keytool -delete -alias unifi -keystore /usr/lib/unifi/data/keystore
keytool -trustcacerts -importkeystore \
    -deststorepass aircontrolenterprise \
    -destkeypass aircontrolenterprise \
    -destkeystore /usr/lib/unifi/data/keystore \
    -srckeystore unifi.p12 -srcstoretype PKCS12 \
    -srcstorepass aircontrolenterprise \
    -alias unifi
rm -f unifi.p12
java -jar /usr/lib/unifi/lib/ace.jar import_cert \
    /etc/letsencrypt/live/${DOMAIN}/cert.pem \
    /etc/letsencrypt/live/${DOMAIN}/chain.pem
service unifi start
