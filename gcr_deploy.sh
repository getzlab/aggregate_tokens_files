#!/bin/bash

[ ! -f mcc/aggregate_tokens_files ] && { echo "You must first compile application before building Docker image!"; exit 1; }

docker build -t broadinstitute/aggregate_tokens_files:v1 .

docker tag broadinstitute/aggregate_tokens_files:v1 gcr.io/broad-getzlab-workflows/aggregate_tokens_files:v1
docker tag broadinstitute/aggregate_tokens_files:v1 gcr.io/broad-getzlab-workflows/aggregate_tokens_files:latest

docker push gcr.io/broad-getzlab-workflows/aggregate_tokens_files:v1
docker push gcr.io/broad-getzlab-workflows/aggregate_tokens_files:latest
