#!/bin/bash

status=`ip route | grep tun0 | wc -l`
if [ $status == "0" ]; then
    echo "VPN: NO"
else
    echo "VPN: yes"
fi

