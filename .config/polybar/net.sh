#!/bin/sh

status=$(ip addr | grep mull)
if [ -z "$status" ]; then echo "no"; else echo "yes"; fi

