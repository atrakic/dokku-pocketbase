#!/bin/bash

HERE=$(dirname $(readlink -f $0))
source $HERE/env.sh

if [ -z "$myapp" ]; then
  echo ":: Error: $(basename "$0") - No app to clean ::"
  exit 1
fi

echo ":: $(basename "$0"): Using dokku on $fqdn ($ip) ::"
$dokku apps:destroy "$myapp"
