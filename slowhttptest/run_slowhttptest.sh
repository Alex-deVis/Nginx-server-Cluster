#!/bin/bash

out=${1:-stats_nginx}

slowhttptest -c 65539 -H -g -o "$out" -i 1 -l 240 -r 300 -t GET -u http://172.18.0.2:30080 -x 24 -p 3

