#!/bin/bash
/usr/bin/sed  \
-e "s/\${PUBLIC_HOST}/${PUBLIC_HOST}/g" \
-e "s/\${CERTS_PATH}/${CERTS_PATH}/g"  \
< /etc/nginx/conf.d/default.conf.tmpl \
> /etc/nginx/conf.d/default.conf
