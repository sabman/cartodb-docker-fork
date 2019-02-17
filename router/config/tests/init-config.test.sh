#!/bin/bash
PROJROOT="router/config"
export PUBLIC_HOST="example.com"
export CERTS_PATH="\/etc\/letsencrypt\/live"
/usr/bin/sed  \
-e "s/\${PUBLIC_HOST}/${PUBLIC_HOST}/g" \
-e "s/\${CERTS_PATH}/${CERTS_PATH}/g"  \
< ${PROJROOT}/tests/cartodb.nginx.proxy.test.conf \
> ${PROJROOT}/tests/cartodb.nginx.proxy.output.conf

DIFF=$(diff ${PROJROOT}/tests/cartodb.nginx.proxy.output.conf ${PROJROOT}/tests/cartodb.nginx.proxy.expected.conf) 
if [ "$DIFF" != "" ] 
then
    echo "[FAILED] different from expected"
    echo "${DIFF}"
fi
