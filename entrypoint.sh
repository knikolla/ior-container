#!/bin/bash
set -xe

NP="${NP:-1}"
BLOCK_SIZE="${BLOCK_SIZE:-1G}"
TRANSFER_SIZE="${TRANSFER_SIZE:-16M}"
OUTPUT_PATH="${OUTPUT_PATH:-/tmp/test_ior}"
ITERATIONS="${ITERATIONS:-3}"

rm -rf "$OUTPUT_PATH*"

mpiexec --hosts localhost \
    -np $NP \
    /usr/local/bin/ior \
    -a POSIX \
    -b $BLOCK_SIZE \
    -t $TRANSFER_SIZE \
    -o $OUTPUT_PATH \
    -w -r -C -F \
    -i $ITERATIONS
