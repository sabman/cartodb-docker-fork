FROM nginx:1.13

# Build ARGS
ARG PUBLIC_HOST
ARG CERTS_PATH

RUN apt-get update \
    # Install openssl to use when trying to add self signed certs
    && apt-get install -y --no-install-recommends openssl

# copy the reverse proxy config template
COPY cartodb.nginx.proxy.conf /etc/nginx/conf.d/default.conf.tmpl
# copy config init script: it uses PUBLIC_HOST and CERTS_PATH to 
# generate a production reverse proxy config
COPY config/init-config.sh /etc/nginx/init-config.sh
RUN chmod u+x /etc/nginx/init-config.sh
RUN apt-get update && apt-get install -y --no-install-recommends vim-tiny
RUN /etc/nginx/init-config.sh
