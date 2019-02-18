FROM nginx:1.13
# copy config init script: it uses PUBLIC_HOST and CERTS_PATH to generate a production config
COPY config/init-config.sh /etc/nginx/
# copy the config template
COPY cartodb.nginx.proxy.conf /etc/nginx/conf.d/default.conf.tmpl
RUN chmod u+x /etc/nginx/init-config.sh
# Build ARGS
ARG PUBLIC_HOST
ARG CERTS_PATH
RUN /etc/nginx/init-config.sh
