FROM postgres:10

RUN apt-get update \
  && apt-get -y --no-install-recommends install \
    build-essential \
    git \
    curl \
    wget \
    ca-certificates \
    # PostgreSQL
    libpq-dev \
    libpq5 \
    postgresql-contrib-10 \
    postgresql-plpython-10 \
    postgresql-10-plproxy \
    postgresql-server-dev-10 \
    # GIS:
    # - Proj
    libproj-dev \
    proj-bin \
    proj-data \
    # - JSON
    python-simplejson \
    # - GEOS
    libgeos-c1v5 \
    libgeos-dev \
    # - GDAL
    gdal-bin \
    libgdal-dev \
    # PostGIS
    liblwgeom-2.5.0 \
    libxml2-dev \
    postgis \
    postgresql-10-postgis-2.5 \
    postgresql-10-postgis-2.5-scripts \
    # crankshaft deps
    python2.7-dev \
    # dataservices deps
    ruby \
  && rm -rf /var/lib/apt/lists/*

# https://github.com/CartoDB/cartodb-postgresql version
ENV CARTODB_POSTGRESQL_VERSION=0.24.0
# https://github.com/CartoDB/crankshaft version
ENV CRANKSHAFT_VERSION=0.8.1
# https://github.com/CartoDB/data-services
ENV DATASERVICES_VERSION=0.0.2
# https://github.com/CartoDB/dataservices-api
ENV DATASERVICESAPI_VERSION=python-0.20.2
# https://github.com/CartoDB/observatory-extension
ENV OBSERVATORY_VERSION=1.9.0

RUN curl https://bootstrap.pypa.io/get-pip.py | python \
  # CartoDB main postgresql extensions
  && git clone \
    --branch ${CARTODB_POSTGRESQL_VERSION} \
    --depth 1 git://github.com/CartoDB/cartodb-postgresql.git \
  && cd cartodb-postgresql \
  && make all install \
  && cd / \
  # Crankshaft extensions
  && git clone \
    --branch ${CRANKSHAFT_VERSION} \
    --depth 1 git://github.com/CartoDB/crankshaft.git \
  && cd /crankshaft \
  && make install \
  # Numpy gets upgraded after scikit-learn is installed
  # make sure scikit-learn is compatible with currently installed numpy, by reinstalling
  && pip install --force-reinstall --no-cache-dir scikit-learn==0.14.1 \
  # Dataservices / geocoder
  && cd / && git clone \
    --branch ${DATASERVICES_VERSION} \
    --depth 1 git://github.com/CartoDB/data-services.git \
  && cd /data-services/geocoder/extension \
  && PGUSER=$POSTGRES_USER make all install \
  && cd / && git clone \
    --branch ${DATASERVICESAPI_VERSION} \
    --depth 1 git://github.com/CartoDB/dataservices-api.git \
  && cd /dataservices-api/server/extension \
  && PGUSER=$POSTGRES_USER make install \
  && cd ../lib/python/cartodb_services \
  && pip install -r requirements.txt && pip install . \
  && cd ../../../../client \
  && PGUSER=$POSTGRES_USER make install \
  # Observatory extension
  && cd / && git clone \
    --branch ${OBSERVATORY_VERSION} \
    --depth 1 git://github.com/CartoDB/observatory-extension.git \
  && cd observatory-extension \
  && PGUSER=$POSTGRES_USER make deploy \
  # postgres initdb scripts
  && mkdir -p /docker-entrypoint-initdb.d

COPY initdb-postgis.sh /docker-entrypoint-initdb.d/01-postgis.sh
RUN chmod +rx /docker-entrypoint-initdb.d/01-postgis.sh

# Let Postgres listen on all addresses (it's just localhost by default).
ENTRYPOINT [ "docker-entrypoint.sh", "postgres", "-c", "listen_addresses=*" ]

# Empty CMD directive to override CMD in the base image.
# Additional configuration options can be passed via a custom command.
CMD []
