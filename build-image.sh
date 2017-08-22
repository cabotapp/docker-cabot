#!/bin/sh -e
set -a
source .env
docker build --squash -t cabotapp/cabot -t cabotapp/cabot:$CABOT_VERSION -t cabotapp/cabot:latest --build-arg CABOT_VERSION=$CABOT_VERSION -f Dockerfile .
