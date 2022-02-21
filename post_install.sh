#!/bin/sh -x
IP_ADDRESS=$(ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}')

pw user add lazylib -c lazylibrarian -u 1070 -d /nonexistent -s /usr/bin/nologin

ln -s /usr/local/bin/python3.8 /usr/local/bin/python

pip install apprise
pip install Pillow

mkdir /usr/local/lazylibrarian
git clone https://gitlab.com/LazyLibrarian/LazyLibrarian.git /usr/local/lazylibrarian
cp /usr/local/lazylibrarian/init/freebsd.initd /usr/local/etc/rc.d/lazylibrarian
chmod 755 /usr/local/etc/rc.d/lazylibrarian
chown -R lazylib:lazylib /usr/local/lazylibrarian

sysrc lazylibrarian_enable="YES"
sysrc lazylibrarian_user="lazylib"

service lazylibrarian start

echo -e "LazyLibrarian now installed.\n" > /root/PLUGIN_INFO
echo -e "\nGo to http://$IP_ADDRESS:5299\n" >> /root/PLUGIN_INFO