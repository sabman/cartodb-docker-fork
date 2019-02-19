#!/bin/bash
set -x

/bin/sed \
-e "s~\${PUBLIC_HOST}~${PUBLIC_HOST}~" \
-e "s~\${CERTS_PATH}~${CERTS_PATH}~"  \
< /etc/nginx/conf.d/default.conf.tmpl \
> /etc/nginx/conf.d/default.conf

## This is an attempt at creating a self signed certificate 
# =========================================================

## Generate dhparam:
# openssl dhparam -out ${CERTS_PATH}/dhparam-2048.pem 2048

## Cenerate key and cert files:
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privkey.pem -out fullchain.pem -subj "/C=DE/ST=Berlin/L=Berlin/O=OrgName/OU=IT Department/CN=${PUBLIC_HOST}"

## Create location for the CERTS based on public hostname
# mkdir -p "${CERTS_PATH}/${PUBLIC_HOST}"
# mv privkey.pem ${CERTS_PATH}/${PUBLIC_HOST}/
# mv fullchain.pem ${CERTS_PATH}/${PUBLIC_HOST}/

# nginx -g  "daemon off;"