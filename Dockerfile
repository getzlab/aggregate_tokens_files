FROM gcr.io/broad-getzlab-workflows/matlab_runtime_r2016a:latest

WORKDIR app

COPY mcc/aggregate_tokens_files .
