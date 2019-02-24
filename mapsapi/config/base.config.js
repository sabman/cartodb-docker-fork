const PUBLIC_HOST = process.env.PUBLIC_HOST || 'localhost';
const PUBLIC_PORT = process.env.PUBLIC_PORT || '80';
const PUBLIC_URL = (
  PUBLIC_PORT == '80'
  ? PUBLIC_HOST
  : `${PUBLIC_HOST}:${PUBLIC_PORT}`
);

module.exports = {
  host: '0.0.0.0',
  node_host: '0.0.0.0',
  // user_from_host: '^([^\\.]+)\\.',
  user_from_host: '\/user\/(.*)$',
  postgres: {
    host: 'cartodb-postgis',
  },
  postgis: {
    host: 'cartodb-postgis',
  },
  redis: {
    host: 'cartodb-redis',
  },
  resources_url_templates: {
    http: PUBLIC_URL + '/user/{{=it.user}}/api/v1/map',
    https: PUBLIC_URL + '/user/{{=it.user}}/api/v1/map'
  }
  // Base URLs for the APIs
  //
  // See http://github.com/CartoDB/Windshaft-cartodb/wiki/Unified-Map-API
  //
  // Base url for the Templated Maps API
  // "/api/v1/map/named" is the new API,
  // "/tiles/template" is for compatibility with versions up to 1.6.x
  ,base_url_templated: '(?:/api/v1/map/named|/user/:user/api/v1/map/named|/tiles/template)'
  // Base url for the Detached Maps API
  // "maps" is the the new API,
  // "tiles/layergroup" is for compatibility with versions up to 1.6.x
  ,base_url_detached: '(?:/api/v1/map|/user/:user/api/v1/map|/tiles/layergroup)'
  ,serverMetadata: {
    cdn_url: {
      http: PUBLIC_URL + '/user',
      https: PUBLIC_URL + '/user',
    },
  },
  analysis: {
    batch: {
      endpoint: "https://cartodb-router/api/v2/sql/job",
      hostHeaderTemplate: "{{=it.username}}.localhost.lan"
    }
  }
  ,millstone: {
    // Needs to be writable by server user
    cache_basedir: '/tmp/cdb-tiler-dev/millstone-dev'
  }

  // , "varnish": { TODO: add varnish
  //   "host": "localhost",
  // }
};
