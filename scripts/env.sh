# Description: Environment variables for the scripts
myapp=${myapp:-}                        # name of the app
your_cert_email="${your_cert_email:-}"  # your email address for letsencrypt
s3_backup_bucket="${s3_backup_bucket:-}" # AWS s3 bucket for backups

fqdn=$(make -s -f ./infra/Makefile outputs | jq ".[].fqdn.value" | xargs)
ip=$(make -s -f ./infra/Makefile outputs | jq ".[].vmPublicIPAddress.value"| xargs)

_user="dokku"
_command="dokku"


if [ -z "$fqdn" ]; then
    echo "FQDN is not set. Please set it in the Makefile"
    exit 1
fi

if [ -z "$ip" ]; then
    echo "IP is not set. Please set it in the Makefile"
    exit 1
fi

dokku="ssh \
    -o LogLevel=ERROR \
    -o StrictHostKeychecking=no \
    -o UserKnownHostsFile=/dev/null \
    $_user@$ip $_command"
