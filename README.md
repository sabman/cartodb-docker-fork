# TODO:

- [x] Fix "Sorry, we can't find CARTO user 'admin'. Please check that you have entered the correct domain."
  > Related to https://github.com/CartoDB/node-cartodb-redis/blob/v0.3.0/lib/carto_metadata.js#L81 > https://github.com/CartoDB/CartoDB-SQL-API/issues/149 > `docker-compose exec cartodb-editor ./script/restore_redis`
- [x] Cannot connect to database
- [ ] mapsapi check: `hostHeaderTemplate: "{{=it.username}}.localhost.lan"`
- [ ] check port for app_config
- [ ] `{"error":["PL/Proxy function cdb_dataservices_client._cdb_service_quota_info(2): [dataservices_db] PQconnectPoll: FATAL: role \"geocoder_api\" does not exist\n"]}`
- [ ] Running analysis gives: `Unable to enqueue SQL API batch job`
- When previewing the data in tables getting this error: `"Template 'tpl_077e94bf_8fa9_4684_96af_b8b58aa624b4' of user 'admin' not found"`
