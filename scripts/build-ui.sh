#!/bin/bash

set -ex

# --mount type=bind,source=$(pwd),target=/app/ui-build
# --mount type=bind,source=$(pwd)/site,target=/host-site
docker build -t ui-builder -f scripts/build-ui/Dockerfile .
docker run --rm -ti -v $(pwd)/site:/host-site ui-builder
sudo chmod -R 0755 site/
sudo chown -R $(whoami) site/
mv site/ agent/site/
