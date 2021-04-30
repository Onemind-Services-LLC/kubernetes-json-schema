#!/bin/bash -xe

version="$1"

STANDALONE_STRICT="schema/${version}-standalone-strict"
STANDALONE="schema/${version}-standalone"
LOCAL="schema/${version}-local"
V="schema/${version}"

# This script uses openapi2jsonschema to generate a set of JSON schemas for
# the specified Kubernetes versions in three different flavours:
#
#   X.Y.Z - URL referenced based on the specified GitHub repository
#   X.Y.Z-standalone - de-referenced schemas, more useful as standalone documents
#   X.Y.Z-standalone-strict - de-referenced schemas, more useful as standalone documents, additionalProperties disallowed
#   X.Y.Z-local - relative references, useful to avoid the network dependency

schema=https://raw.githubusercontent.com/kubernetes/kubernetes/${version}/api/openapi-spec/swagger.json
prefix=https://kubernetesjsonschema.dev/${version}/_definitions.json

if [ ! -d "${STANDALONE_STRICT}" ]; then
  openapi2jsonschema -o "${STANDALONE_STRICT}" --expanded --kubernetes --stand-alone --strict "${schema}"
  openapi2jsonschema -o "${STANDALONE_STRICT}" --kubernetes --stand-alone --strict "${schema}"
fi

if [ ! -d "${STANDALONE}" ]; then
  openapi2jsonschema -o "${STANDALONE}" --expanded --kubernetes --stand-alone "${schema}"
  openapi2jsonschema -o "${STANDALONE}" --kubernetes --stand-alone "${schema}"
fi

if [ ! -d "${LOCAL}" ]; then
  openapi2jsonschema -o "${LOCAL}" --expanded --kubernetes "${schema}"
  openapi2jsonschema -o "${LOCAL}" --kubernetes "${schema}"
fi

if [ ! -d "${V}" ]; then
  openapi2jsonschema -o "${V}" --expanded --kubernetes --prefix "${prefix}" "${schema}"
  openapi2jsonschema -o "${V}" --kubernetes --prefix "${prefix}" "${schema}"
fi
