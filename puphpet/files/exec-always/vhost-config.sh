#!/bin/bash
#
if ! grep -R "vhosts.d" "/etc/httpd/conf/httpd.conf"; then
    echo 'Adding Vhost config'
    printf "IncludeOptional \"/etc/httpd/vhosts.d/*.conf\"" >> /etc/httpd/conf/httpd.conf
    mkdir /etc/httpd/vhosts.d
fi