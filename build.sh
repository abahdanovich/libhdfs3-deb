#!/bin/bash

set -e
set -o pipefail

cd "`dirname $0`"

docker build \
    -t libhdfs3-deb \
    .
