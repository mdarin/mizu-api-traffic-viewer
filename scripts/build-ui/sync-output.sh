#!/bin/bash
# copy results to the host mounted directory
rsync -a --delete /output/ /host-site/
echo "Building artifacts copied to host directory"
