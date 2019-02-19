# TODO:

- [x] Fix "Sorry, we can't find CARTO user 'admin'. Please check that you have entered the correct domain."
  > Related to https://github.com/CartoDB/node-cartodb-redis/blob/v0.3.0/lib/carto_metadata.js#L81 > https://github.com/CartoDB/CartoDB-SQL-API/issues/149 > `docker-compose exec cartodb-editor ./script/restore_redis`
- [ ] Cannot connect to database
- [ ] mapsapi check: `hostHeaderTemplate: "{{=it.username}}.localhost.lan"`
- [ ] check port for app_config
