#!/bin/bash

/bin/sed \
-e "s~\${PUBLIC_HOST}~${PUBLIC_HOST}~" \
-e "s~\${CERTS_PATH}~${CERTS_PATH}~"  \
< /etc/nginx/conf.d/default.conf.tmpl \
> /etc/nginx/conf.d/default.conf

