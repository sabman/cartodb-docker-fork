module.exports = {
  node_host: '0.0.0.0',
  db_host: 'cartodb-postgis',
  db_port: 5432,
  redis_host: 'cartodb-redis',
  // Send log messages to stdout.
  log_filename: undefined,
  user_from_host: "^(.*)\\.localhost\\.lan"
};
