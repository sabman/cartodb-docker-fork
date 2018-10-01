FROM postgres:10

RUN apt-get update \
  && apt-get -y --no-install-recommends install \
    build-essential \
    git \
    # PostgreSQL
    libpq-dev \
    libpq5 \
    postgresql-contrib-10 \
    postgresql-plpython-10 \
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
  && rm -rf /var/lib/apt/lists/*

# CartoDB/cartodb-postgresql version
ENV CARTODB_POSTGRESQL_VERSION=0.24.0

RUN git clone \
    --branch ${CARTODB_POSTGRESQL_VERSION} \
    --depth 1 git://github.com/CartoDB/cartodb-postgresql.git \
  && cd cartodb-postgresql \
  && make all install \
  && mkdir -p /docker-entrypoint-initdb.d

COPY initdb-postgis.sh /docker-entrypoint-initdb.d/01-postgis.sh

# Let Postgres listen on all addresses (it's just localhost by default).
ENTRYPOINT [ "docker-entrypoint.sh", "postgres", "-c", "listen_addresses=*" ]

# Empty CMD directive to override CMD in the base image.
# Additional configuration options can be passed via a custom command.
CMD []
