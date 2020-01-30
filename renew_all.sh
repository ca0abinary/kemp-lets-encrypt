#!/bin/sh
cd /etc/letsencrypt/configs/
CONFIGS=$(find . -iname "*.conf" | sed s/.conf$//g)

for conf in $CONFIGS
do
        echo "Processing $conf..."

        if [ -f "$conf.pre.sh" ]; then
                sh -c "$conf.pre.sh"
        fi

        certbot --config "$conf.conf" --expand --non-interactive --server https://acme-v02.api.letsencrypt.org/directory certonly

        if [ -f "$conf.post.sh" ]; then
                sh -c "$conf.post.sh"
        fi
done
