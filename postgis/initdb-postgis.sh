#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

echo "Creating user 'publicuser'..."
createuser publicuser --no-createrole --no-createdb --no-superuser -U $PGUSER
echo "Creating user 'tileuser'..."
createuser tileuser --no-createrole --no-createdb --no-superuser -U $PGUSER

# Initialize template_postgis database. We create a template database in postgresql that will
# contain the postgis extension. This way, every time CartoDB creates a new user database it just
# clones this template database
echo "Creating database 'template_postgis'..."
createdb -T template0 -O postgres -U $PGUSER -E UTF8 template_postgis
# createlang -d template_postgis plpgsql;
psql -U $PGUSER template_postgis -c "CREATE LANGUAGE plpgsql;"
psql -d postgres -c "UPDATE pg_database SET datistemplate='true' \
  WHERE datname='template_postgis'"
psql -c "CREATE EXTENSION plpythonu;"

echo "Creating extensions postgis, postgis_topology, plpythonu, crankshaft, plproxy"
psql -U $PGUSER template_postgis -c "CREATE EXTENSION postgis;"
psql -U $PGUSER template_postgis -c "CREATE EXTENSION postgis_topology;"
psql -U $PGUSER template_postgis -c "GRANT ALL ON geometry_columns TO PUBLIC;"
psql -U $PGUSER template_postgis -c "GRANT ALL ON spatial_ref_sys TO PUBLIC;"
psql -U $PGUSER template_postgis -c "CREATE EXTENSION plpythonu;"
psql -U $PGUSER template_postgis -c "CREATE EXTENSION crankshaft VERSION 'dev';"
psql -U $PGUSER template_postgis -c "CREATE EXTENSION plproxy;"
