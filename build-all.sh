#!/bin/bash -e

# All k8s versions, starting from 1.31
VERSIONS=$(git ls-remote --refs --tags https://github.com/kubernetes/kubernetes.git \
  | cut -d/ -f3 \
  | grep -E '^v1\.(3[1-9]|[4-9][0-9])\.[0-9]+$')

# This script uses openapi2jsonschema to generate a set of JSON schemas for
# the specified Kubernetes versions in three different flavours:
#
#   X.Y.Z - URL referenced based on the specified GitHub repository
#   X.Y.Z-standalone - de-referenced schemas, more useful as standalone documents
#   X.Y.Z-standalone-strict - de-referenced schemas, more useful as standalone documents, additionalProperties disallowed
#   X.Y.Z-local - relative references, useful to avoid the network dependency

# Remove master folders
rm -rf schema/master*

for VERSION in $VERSIONS master; do
  ./build.sh "${VERSION}"
done
