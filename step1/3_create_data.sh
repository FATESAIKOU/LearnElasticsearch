#!/usr/bin/env bash

## Create an index named "books" with appropriate mappings
curl --cacert http_ca.crt -u elastic:$ELASTIC_PASSWORD \
  -H 'Content-Type: application/json' \
  -X PUT https://localhost:9200/books \
  -d '{
    "mappings": {
      "properties": {
        "title": {"type":"text"},
        "author":{"type":"keyword"},
        "year":  {"type":"integer"},
        "pages": {"type":"integer"}
      }
    }
  }'

## Bulk insert sample book data into the "books" index
curl --cacert http_ca.crt -u elastic:$ELASTIC_PASSWORD \
  -H 'Content-Type: application/x-ndjson' \
  -X POST https://localhost:9200/_bulk \
  -d '
{ "index": { "_index": "books", "_id":"1" } }
{ "title":"Designing Data-Intensive Applications", "author":"Kleppmann", "year":2017, "pages":616 }
{ "index": { "_index": "books", "_id":"2" } }
{ "title":"Lucene in Action", "author":"McCandless", "year":2010, "pages":475 }
{ "index": { "_index": "books", "_id":"3" } }
{ "title":"Elasticsearch: The Definitive Guide", "author":"Gormley", "year":2015, "pages":724 }
{ "index": { "_index": "books", "_id":"4" } }
{ "title":"Clean Code", "author":"Martin", "year":2008, "pages":464 }
{ "index": { "_index": "books", "_id":"5" } }
{ "title":"The Pragmatic Programmer", "author":"Hunt", "year":1999, "pages":352 }
'
