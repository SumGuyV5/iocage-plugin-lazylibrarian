#!/bin/sh -x
IP_ADDRESS=$(ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}')

ln -s /usr/local/bin/python3.8 /usr/local/bin/python

pip install apprise
pip install Pillow

mkdir /usr/local/lazylibrarian
git clone https://gitlab.com/LazyLibrarian/LazyLibrarian.git /usr/local/lazylibrarian
cp /usr/local/lazylibrarian/init/freebsd.initd /usr/local/etc/rc.d/lazylibrarian
chmod 555 /usr/local/etc/rc.d/lazylibrarian

sysrc lazylibrarian_enable="YES"
sysrc lazylibrarian_user="root"
sysrc lazylibrarian_dir="/usr/local/lazylibrarian"

service lazylibrarian start

echo -e "LazyLibrarian now installed.\n" > /root/PLUGIN_INFO
echo -e "\nGo to $IP_ADDRESS:5299\n" >> /root/PLUGIN_INFO