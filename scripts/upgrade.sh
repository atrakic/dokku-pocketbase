#!/bin/bash

HERE=$(dirname $(readlink -f "$0"))
source "$HERE"/env.sh

VERSION="$1"
if [ -n "$VERSION" ]; then
    echo ":: $(basename "$0"): Using dokku on $fqdn ($ip) ::"
    echo "Upgrading to version: $VERSION"
    $dokku docker-options:add "$myapp" build "--build-arg CLICKS_VERSION=$VERSION"
    $dokku ps:rebuild "$myapp"
fi