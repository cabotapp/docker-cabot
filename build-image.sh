#!/bin/sh -e
set -a
source .env
docker build -t cabot-build:$CABOT_VERSION --build-arg CABOT_VERSION=$CABOT_VERSION -f Dockerfile.build .
rm -rf build/*.whl
docker run --rm -v `pwd`/build:/build cabot-build:$CABOT_VERSION "cp /code/dist/*.whl /build/"

mkdir -p $CABOT_VERSION/
cp template/Dockerfile $CABOT_VERSION/
cp build/*.whl $CABOT_VERSION/

docker build --squash -t cabotapp/cabot -t cabotapp/cabot:$CABOT_VERSION -f $CABOT_VERSION/Dockerfile $CABOT_VERSION/
echo "Successfully built image cabotapp/cabot:$CABOT_VERSION"
docker tag cabotapp/cabot:$CABOT_VERSION cabotapp/cabot:latest
echo "Tagged image as cabotapp/cabot:latest"
