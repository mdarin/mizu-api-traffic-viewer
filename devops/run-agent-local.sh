#!/bin/sh
set -ex

docker run -it mdarin/mizu-dust-remove -i any --tap --api-server-address ws://172.17.0.2:8899/wsTapper --nodefrag --max-live-streams 500
