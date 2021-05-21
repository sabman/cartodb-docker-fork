FROM ubuntu:xenial-20210416

RUN apt-get update \
  # Install locales package, and update locale
  && apt-get install -y --no-install-recommends locales \
  && locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
  # Install python-software-properties package to make it easier to use PPAs.
  && apt-get -y --no-install-recommends install \
    software-properties-common python-software-properties \
  # Add PPAs.
  && add-apt-repository ppa:cartodb/gis \
  && add-apt-repository ppa:cartodb/nodejs \
  && add-apt-repository ppa:cartodb/postgresql-10 \
  && add-apt-repository ppa:brightbox/ruby-ng \
  # Install apt packages.
  && apt-get update && apt-get -y --no-install-recommends install \
    # build essentials
    autoconf \
    binutils-doc \
    bison \
    build-essential \
    flex \
    # some utils
    less vim.tiny \
    # Git
    git \
    # networking tools, because 'ip' is required by uuidtools gem to get mac addr
    iproute2 \
    # PostgreSQL
    libpq5 \
    libpq-dev \
    postgresql-10 \
    postgresql-plpython-10 \
    postgresql-client-10 \
    postgresql-client-common \
    # GIS:
    # - Proj
    proj-bin \
    proj-data \
    libproj-dev \
    # - JSON
    libjson0 \
    libjson0-dev \
    python-simplejson \
    # - GEOS
    libgeos-c1v5 \
    libgeos-dev \
    # - GDAL
    gdal-bin \
    libgdal-dev \
    libgdal1-dev \
    # Postgis
    libxml2-dev \
    postgis \
    # NodeJS and dependencies
    libcairo2-dev \
    libgif-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libpixman-1-0 \
    libpixman-1-dev \
    nodejs \
    # Ruby
    ruby2.2 \
    ruby2.2-dev \
    ruby-bundler \
    libreadline6-dev \
    openssl \
    # Python dependencies
    imagemagick \
    python-all-dev \
    libicu-dev \
    unp \
    zip \
    # for user migration rake tasks
    redis-tools \
    # Other dependencies
    unzip \
    wget \
  # Install Pip.
  && wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py \
  && python /tmp/get-pip.py \
  # Clean up.
  && rm /tmp/get-pip.py \
  && rm -rf /var/lib/apt/lists/*

# Install Ruby utilities.
RUN gem install compass

# CartoDB/cartodb version
ENV CARTODB_VERSION=4.21.0

# Download the Editor program, using the specified release tag.
RUN git clone --recursive --branch v${CARTODB_VERSION} --depth 1 https://github.com/CartoDB/cartodb.git

WORKDIR /cartodb

# Environment type.
ARG RAILS_ENV=development
ENV RAILS_ENV=$RAILS_ENV


# Install Ruby dependencies.
RUN bundle install \
  # Install Python dependencies.
  && CPLUS_INCLUDE_PATH=/usr/include/gdal \
    C_INCLUDE_PATH=/usr/include/gdal \
    PATH=$PATH:/usr/include/gdal \
    pip install -r python_requirements.txt \
  # Install Node dependencies
  && npm install \
  # Add dependencies of configuration merge script.
  && npm install \
    js-yaml \
    yargs

COPY config/* /cartodb/config/

# Compile static assets
RUN PATH=$PATH:/cartodb/node_modules/grunt-cli/bin \
    bundle exec grunt --environment=${RAILS_ENV} \
  # Clean up.
  && rm -rf \
    /root/.cache \
    /root/.bundle \
    /root/.gem \
    /root/.npm \
  && mkdir -p /cartodb/docker-entrypoint-util

EXPOSE 3000

# Copy resources.
COPY util/* /cartodb/docker-entrypoint-util/
COPY docker-entrypoint.sh /cartodb/

# We configure the application using just the base config files here. Additional configuration files
# can be merged with the base by supplying their filenames as --app_config or --database option
# arguments in the CMD.
ENTRYPOINT [ \
  "./docker-entrypoint.sh", \
  "--app_config", "base.app_config.yml", \
  "--database", "base.database.yml" \
]

# We merge the sample config files with the base configs by default.
# Custom configuration may be used by extending this image as follows:
# 1) COPY one or more config files into /cartodb/config/.
# 2) Pass the filename(s) as --app_config or --database option arguments in the CMD.
CMD [ \
  "--app_config", "app_config.yml.sample", \
  "--database", "database.yml.sample" \
]
