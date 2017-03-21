#!/bin/sh
find /etc/letsencrypt/configs/ -iname "*.pre.sh" -exec {} \;
find /etc/letsencrypt/configs/ -iname "*.conf" -exec certbot --config {} --non-interactive certonly \;
find /etc/letsencrypt/configs/ -iname "*.post.sh" -exec {} \;
