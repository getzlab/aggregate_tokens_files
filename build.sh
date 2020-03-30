#!/bin/bash

# Requires MATLAB with mcc support to build.

(cd funcs && mex hist2d_fast.c ) && \
  mkdir mcc && mcc -m -I funcs -d mcc aggregate_tokens_files
