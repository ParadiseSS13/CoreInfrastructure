#!/bin/sh
set -e

# Not .sh just in case we ll have some scripting language scripts in there
cp /custom/scripts/* /usr/local/bin
chown root:root /usr/local/bin/*
chmod +x /usr/local/bin/*

cp /custom/crontab /etc/crontabs/root
chown root:root /etc/crontabs/root
chmod 0600 /etc/crontabs/root

apk add --no-cache $(cat /custom/packages.txt)

echo "Initialized paracron. Launching crond..."
exec crond -f -l 2
