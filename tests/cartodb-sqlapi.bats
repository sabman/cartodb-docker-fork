#!/usr/bin/env bats

@test "end point works" {

  run "curl 'https://cartodb.spatial-labs.com/user/admin/api/v2/sql?sort_order=asc&rows_per_page=0&page=0&api_key=cb912d64c044a3b7bf862b403891975ea9b29b1c&q=SELECT+*+FROM+(SELECT+*+FROM+admin.buildings)+__wrapped}' -H 'Content-Type: application/json'"

  [ "$status" -eq 0 ]
}
