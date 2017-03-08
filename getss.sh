#!/bin/bash
ps aux|grep sslocal|awk '{print $2}'|xargs kill -9
SS_INFO=~/tmp/ss_server.info
curl 'https://zxing.org/w/decode?u=http://free.shadowsocks8.cc/images/server01.png' > $SS_INFO
echo "SS_INFO: "$SS_INFO
ss=~/tmp/ss_decode.info
awk -F '//' '{print $2}' $SS_INFO|sed '/^$/d'|cut -d '<' -f 1|uniq|base64 -d > $ss
echo "ss: "$ss
method=$(awk -F ':' '{print $1}' $ss)
password=$(awk -F ':' '{print $2}' $ss|cut -d '@' -f 1)
server=$(awk -F ':' '{print $2}' $ss|cut -d '@' -f 2)
port=$(awk -F ':' '{print $3}' $ss)
echo 'sslocal -s '$server' -p '$port' -l 1080 -k '$password' -m '$method
sslocal -s $server -p $port -l 1080 -k $password -m $method > ~/tmp/getss.log 2>&1 &
