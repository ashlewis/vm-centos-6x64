#!/bin/bash
#



CONFIG_FILE=${VAGRANT_CORE_FOLDER}/files/private/build.conf

if [[ -f $CONFIG_FILE ]]; then
    . $CONFIG_FILE
fi

mailcatcher --http-ip=$mailcatcher::params::http_ip