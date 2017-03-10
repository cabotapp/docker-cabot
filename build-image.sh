#!/bin/sh -e
set -a
source .env
docker build --squash -t cabotapp/cabot -t cabotapp/cabot:$CABOT_VERSION --build-arg CABOT_VERSION=$CABOT_VERSION -f Dockerfile .
echo "Successfully built image cabotapp/cabot:$CABOT_VERSION"
docker tag cabotapp/cabot:$CABOT_VERSION cabotapp/cabot:latest
echo "Tagged image as cabotapp/cabot:latest"
