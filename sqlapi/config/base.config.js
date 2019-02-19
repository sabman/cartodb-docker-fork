module.exports = {
  // Regular expression pattern to extract username
  // from hostname. Must have a single grabbing block.
  user_from_host: '^([^\\.]+)\\.',
  node_host: '0.0.0.0',
  db_host: 'cartodb-postgis',
  // db_port: "6432", // if pgbouncer is configured
  db_port: '5432',
  redis_host: 'cartodb-redis',
  // Send log messages to stdout.
  log_filename: undefined,
};
