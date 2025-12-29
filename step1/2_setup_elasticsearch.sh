#!/usr/bin/env bash

export ELASTIC_PASSWORD="A*4qOgB-Hr50Y6dmgpjb"

docker cp es01:/usr/share/elasticsearch/config/certs/http_ca.crt ./http_ca.crt

curl --cacert ./http_ca.crt -u "elastic:$ELASTIC_PASSWORD" -X GET "https://localhost:9200/_security/_authenticate?pretty"
