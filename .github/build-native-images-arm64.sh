#!/bin/bash

# Create the container image providing the GraalVM native-image executable on ARM64
# Usage: build-native-images-arm64.sh version-of-the-graalvm-module
# Example:
#    build-native-images-arm64.sh 21.0.0.2-java11

set -e

PREFIX_NAME=automatiko/ubi-quarkus-native-image-arm64
IMAGE=quarkus-native-image-arm64.yaml
BUILD_ENGINE=docker
VERSION=$1
OVERRIDES="{'version': '${VERSION}', 'modules': {'install': [{'name':'graalvm-arm64', 'version': '${VERSION}'}]}}"

echo "Building version ${VERSION}"
echo "Path is $PATH"

virtualenv --python=python3 .cekit
source .cekit/bin/activate

echo "Generating ${PREFIX_NAME}:${VERSION}"
cekit --descriptor ${IMAGE} build \
    --overrides "${OVERRIDES}" \
    ${BUILD_ENGINE} --tag="${PREFIX_NAME}:${VERSION}"
