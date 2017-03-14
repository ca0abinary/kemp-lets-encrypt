#!/bin/sh
find /etc/letsencrypt/configs/ -iname "*.conf" -exec certbot --config {} --agree-tos certonly \;
find /etc/letsencrypt/configs/ -iname "*.post.sh" -exec {} \;
