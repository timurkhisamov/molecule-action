#!/bin/sh

set -x

: "${GITHUB_REPOSITORY?GITHUB_REPOSITORY has to be set. Did you use the actions/checkout action?}"
cd ${GITHUB_REPOSITORY}

molecule ${INPUT_MOLECULE_OPTIONS} ${INPUT_MOLECULE_COMMAND} ${INPUT_MOLECULE_ARGS}
