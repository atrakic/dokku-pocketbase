#!/bin/bash

HERE=$(dirname $(readlink -f "$0"))
source $HERE/env.sh

if [[ -z "$myapp" ]]; then
    echo ":: $(basename "$0"): No app name set ::"
    exit 1
fi
    
echo ":: $(basename "$0"): Using dokku on $fqdn ($ip) ::"
git remote -v | grep -w dokku &>/dev/null || git remote add dokku dokku@"$ip":"$myapp"
git push dokku main
