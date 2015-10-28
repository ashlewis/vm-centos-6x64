#!/bin/bash
#
echo 'Installing phing'
pear channel-discover pear.phing.info
pear install --alldeps phing/phing