#!/bin/bash

set -e
set -o pipefail

cd "`dirname $0`"

rm -rfv dist/*.deb

docker run --rm -it \
    --name libhdfs3-deb-running \
    -v $(pwd)/dist:/root/dist \
    libhdfs3-deb

ls -l dist
