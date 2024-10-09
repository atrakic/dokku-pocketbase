#!/bin/bash

HERE=$(dirname $(readlink -f $0))
source $HERE/env.sh

if [[ -n "$s3_backup_bucket" ]]; then
    echo ":: $(basename $0): Using s3 bucket $s3_backup_bucket ::"
    $dokku litestream:create "$myapp" /var/lib/dokku/data/storage/"$myapp" \
        production.sqlite3 s3://"$s3_backup_bucket"/"$myapp"/production.sqlite3
    $dokku litestream:start "$myapp"
    $dokku litestream:logs "$myapp"
fi
