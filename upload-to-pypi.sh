#!/bin/sh -e

set -a
source .env
docker build -t cabot-build:$CABOT_VERSION --build-arg CABOT_VERSION=$CABOT_VERSION -f Dockerfile.build .

docker run --rm -v ~/.pypirc:/root/.pypirc cabot-build:$CABOT_VERSION "twine upload dist/*.whl dist/*.tar.gz"
