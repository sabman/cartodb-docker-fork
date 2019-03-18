#!/usr/bin/env bats

@test "end point work" {

  run "curl 'https://cartodb.spatial-labs.com/api/v1/map/named?api_key=cb912d64c044a3b7bf862b403891975ea9b29b1c' -H 'Content-Type: application/json' -d @mapconfig.json"

  [ "$status" -eq 0 ]
}
