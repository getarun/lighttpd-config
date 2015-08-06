#!/bin/bash
##################################### Server installation #####################################
## installs lighttpd with ssl support
sudo apt-get install openssl libssl-dev
## follow http://redmine.lighttpd.net/projects/lighttpd/wiki/Docs_SSL#Self-Signed-Certificates
mkdir ~/downloads/
cd ~/downloads/
wget http://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.36.tar.gz
tar zxvf lighttpd-1.4.36.tar.gz
cd lighttpd-1.4.36
./configure --with-openssl --with-openssl-libs=/usr/lib
make
sudo make install
cd ~
lighttpd -v
##################################### Key installation #####################################
###creates new key
openssl req -new -x509 \
    -keyout server.pem -out server.pem \
    -days 365 -nodes
##copies key
sudo mv server.pem /etc/lighttpd/
## changes permissions to be only writeable for root (which is okay, because server gets started as root)
sudo chown root:root /etc/lighttpd/server.pem
chmod 400 /etc/lighttpd/server.pem
##################################### Copies configuration file from repo
sudo cp ~/git-working-dir/lighttpd-config/lighttpd.config /etc/lighttpd/
