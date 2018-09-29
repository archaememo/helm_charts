#!/usr/bin/env bash

srv_port="$SRV_PORT"
script_name=${0##*/}


function log() {
    local msg="$1"
    local timestamp
    timestamp=$(date)
    echo "[$timestamp] [$script_name] $msg" >> /work-dir/log.txt
}


function check_sharding() {
    for shard in `dir /sh-lst`; do
        if ! ( mongo  --eval "sh.status()" | grep "\"_id\" : \"$shard\",  \"host\" :" ); then
            cmd=`cat /sh-lst/$shard`
            mongo admin  --eval "sh.addShard('$cmd')"
            log "add sharding $shard"
        fi
    done
}


log "mongos $1 $2 $2"

# start mongos
nohup mongos $1 $2 $3 &

until mongo --port ${srv_port} "${ssl_args[@]}" --eval "db.adminCommand('ping')"; do
    log "Waiting for config service."
    sleep 2
done

check_sharding

while true; do
   s=$RANDOM
   s=$(($s % 120))
   s=$(($s + 60))
   sleep $s
   check_sharding
done
