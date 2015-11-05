#!/bin/bash
#
mailcatcher --http-ip=$mailcatcher::params::http_ip

if ! grep -R "mailcatcher_custom" "/etc/postfix/main.cf"; then
    echo 'Adding custom mailcatcher config'
    printf "\n# mailcatcher_custom\nrelayhost = 127.0.0.1:1025\n" >> /etc/postfix/main.cf
    /etc/init.d/postfix restart
fi