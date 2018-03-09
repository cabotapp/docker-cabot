#!/bin/sh -e

set -a
source .env
docker build --no-cache  -t cabot-build:$CABOT_VERSION --build-arg CABOT_VERSION=$CABOT_VERSION -f Dockerfile.build .

while true; do
    read -p "Are you sure you want to upload cabot version $CABOT_VERSION? (y/N) " yn
    case $yn in
        [Yy] ) break;;
        * ) exit;;
    esac
done

docker run --rm -v ~/.pypirc:/root/.pypirc cabot-build:$CABOT_VERSION "twine upload dist/*.whl dist/*.tar.gz"
