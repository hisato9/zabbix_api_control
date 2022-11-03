#!/bin/bash

# set zabbix server url
zabbix_url=http://<zabbix-ip>/zabbix/

# set shell directory
current_dir=$(cd $(dirname $0);pwd)

# get authentication token
token_info=`${current_dir}/zabbix_get-token.sh`

# get arguments for vm info
# 1st args : hostgroup name
group_name=$1

# send curl request with parameters
curl -s -d "{
     \"jsonrpc\": \"2.0\",
     \"method\": \"hostgroup.get\",
     \"params\": {
         \"output\": \"extend\",
         \"filter\": {
             \"name\": [
                 \"${group_name}\"
             ]
         }
     },
     \"auth\": ${token_info},
     \"id\": 1
}" -H "Content-Type: application/json-rpc" ${zabbix_url}api_jsonrpc.php | gawk -F'"' '{print $0}' | jq '.result[].groupid'
