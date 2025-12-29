#!/usr/bin/env bash

docker network create elastic
docker pull docker.elastic.co/elasticsearch/elasticsearch:9.2.3

docker run --name es01 --net elastic -p 9200:9200 -it -m 10GB \
    docker.elastic.co/elasticsearch/elasticsearch:9.2.3
