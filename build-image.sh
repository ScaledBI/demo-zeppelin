#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Do not use latest in production
readonly TAG=latest
readonly DOCKER_IMAGE_BASE=scaledbi-demo-zeppelin
readonly IMAGE_NAME="${DOCKER_IMAGE_BASE}:${TAG}"

echo "Building $IMAGE_NAME"
docker build -t "$IMAGE_NAME" .

# You might want to push the image to a repository
# echo "Pushing $IMAGE_NAME"
# docker push "$IMAGE_NAME"
