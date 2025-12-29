#!/usr/bin/env bash

## Test query1
curl --cacert http_ca.crt -u elastic:$ELASTIC_PASSWORD \
    -H 'Content-Type: application/json' \
    -X POST 'https://localhost:9200/_sql?format=txt' \
    -d '{"query": "SELECT author, COUNT(*) AS c FROM books GROUP BY author ORDER BY c DESC"}'

## Test query2
curl --cacert http_ca.crt -u elastic:$ELASTIC_PASSWORD \
    -H 'Content-Type: application/json' \
    -X POST 'https://localhost:9200/_sql?format=txt' \
    -d '{"query": "SELECT title, pages FROM books ORDER BY pages DESC LIMIT 3"}'