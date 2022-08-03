#!/bin/sh

status=$(ip addr | grep tun0)
if [ -z "$status" ]; then echo "no"; else echo "yes"; fi

