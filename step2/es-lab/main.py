# !/usr/bin/env python3

import os
from elasticsearch import Elasticsearch

ES_URL = os.getenv("ES_URL", "https://localhost:9200")
ES_USER = os.getenv("ES_USER", "elastic")
ES_PASSWORD = os.getenv("ELASTIC_PASSWORD")
CA_CERT = os.getenv("CA_CERT_PATH", "../docker/certs/ca/ca.crt")

def main() -> None:
    client = Elasticsearch(
        ES_URL,
        ca_certs=CA_CERT,
        basic_auth=(ES_USER, ES_PASSWORD)
    )

    info = client.info()
    print("cluster_name =", info["cluster_name"])

    index_name = "books_py"
    if not client.indices.exists(index=index_name):
        client.indices.create(
            index=index_name,
            mappings={
                "properties": {
                    "title": {"type": "text"},
                    "author": {"type": "text"},
                    "year": {"type": "integer"},
                }
            },
        )

    if client.count(index=index_name)["count"] == 0:
        client.index(index=index_name, id="1", document={"title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925})
        client.index(index=index_name, id="2", document={"title": "1984", "author": "George Orwell", "year": 1949})
        client.index(index=index_name, id="3", document={"title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960})
        client.indices.refresh(index=index_name)

    response = client.search(
        index=index_name,
        query={"match": {"author": "George Orwell"}},
    )

    hits = response["hits"]["hits"]
    print(f"Found {len(hits)}, resp = ", response)

if __name__ == "__main__":
    main()
