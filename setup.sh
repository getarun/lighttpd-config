#!/bin/bash
###creates new key
mkdir ~/downloads/
cd ~/downloads/
wget http://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.36.tar.gz
tar zxvf lighttpd-1.4.36.tar.gz
cd lighttpd-1.4.36
./configure
make --with-openssl --with-openssl-libs=/usr/lib
sudo make install
cd ~

apt-get install openssl libssl-dev

openssl req -new -x509 \
    -keyout server.pem -out server.pem \
    -days 365 -nodes

##copies key
sudo cp server.pem /etc/lighttpd/ssl/
## changes permissions to be only writeable for root (which is okay, because server gets started as root)
sudo chown root:root /etc/lighttpd/ssl/server.pem
chmod 400 /etc/lighttpd/ssl/server.pem

############################ check if ssl is compiled ######################
#download the lighttpd tarball from http://www.lighttpd.net/download and extract it with
#tar zxvf lighttpd-1.4.20.tar.gz

#Enter into the extracted folder and compile with these configuration flags: ::

#    --with-openssl --with-openssl-libs=/usr/lib

#Remember to change _ --with-openssl-libs= _ to the folder where your openssl libraries are installed into.

#Once compiled, run make and make install. If lighty has successfully compiled SSL the command

#    lighttpd -v

#Should display (Keep in mind that this new lighty version now has (ssl) after lightys name)

#    lighttpd-1.4.11 (ssl) - a light and fast webserver
#    Build-Date: Sep 1 2006 19:09:15
