#!/bin/bash

# login credentials for cartodb user that will be created
DEFAULT_USER=${DEFAULT_USER:-username}
PASSWORD=${PASSWORD:-password}
EMAIL=${EMAIL:-username@example.com}

# host and port on which the app will be exposed
PUBLIC_HOST=${PUBLIC_HOST:-localhost}
PUBLIC_PORT=${PUBLIC_PORT:-80}

echo "Writing the configuration files..."
DEFAULT_USER=$DEFAULT_USER \
  PUBLIC_HOST=$PUBLIC_HOST \
  PUBLIC_PORT=$PUBLIC_PORT \
  ENVIRONMENT=$RAILS_ENV \
  node docker-entrypoint-util/configure $@

if [[ "x$START_RESQUE_ONLY" != "x" ]]; then
  echo "Starting Resque..."
  exec bundle exec ./script/resque
fi

[ -e /cartodb/tmp/pids/server.pid ] && rm /cartodb/tmp/pids/server.pid

echo "Initializing the metadata database..."
# bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate

echo "Creating the default user, who will own the common data..."
#script/create_dev_user "$DEFAULT_USER" "$PASSWORD" "$EMAIL"

echo "Starting the application..."
exec bundle exec rails server -b 0.0.0.0
