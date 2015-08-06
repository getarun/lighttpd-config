#!/bin/bash
###creates new key
openssl req -new -x509 \
    -keyout server.pem -out server.pem \
    -days 365 -nodes

##copies key
sudo cp server.pem /etc/lighttpd/ssl/
## changes permissions to be only writeable for root (which is okay, because server gets started as root)
sudo chown root:root /etc/lighttpd/ssl/server.pem
chmod 400 /etc/lighttpd/ssl/server.pem
