#!/bin/bash
#



CONFIG_FILE=${VAGRANT_CORE_FOLDER}/files/private/build.conf

if [[ -f $CONFIG_FILE ]]; then
    . $CONFIG_FILE
fi

# todo use ip from yaml file vm.network.private_network
#mailcatcher --http-ip=$mailcatcherHttpIp
mailcatcher --http-ip=192.168.60.101