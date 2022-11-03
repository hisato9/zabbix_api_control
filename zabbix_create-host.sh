#!/bin/bash

# set zabbix server url
zabbix_url=http://<zabbix-ip>/zabbix/

# set shell directory
current_dir=$(cd $(dirname $0);pwd)

# get authentication token
token_info=`${current_dir}/zabbix_get-token.sh`

# get arguments for vm info
# 1st args : vm hostname
# 2nd args : vm ip address
# 3rd args : hostgroup name for hostgroup id
host_name=$1
host_ip=$2
group_id=`${current_dir}/zabbix_change-hostgroup_name-id.sh "$3"`

# set parameters for interface
# type : 1(agent)
# main : 1(interface that is used for default)
# useip : 1(connect with ip)
# dns : blank(not use fqdn)
# port : 10050(port:default)

# send curl request with parameters
curl -s -d "{
    \"jsonrpc\": \"2.0\",
    \"method\": \"host.create\",
    \"params\": {
        \"host\": \"${host_name}\",
        \"interfaces\": [
            {
                \"type\": 1,
                \"main\": 1,
                \"useip\": 1,
                \"ip\": \"${host_ip}\",
                \"dns\": \"\",
                \"port\": \"10050\"
            }
        ],
        \"groups\": [
            {
                \"groupid\": ${group_id}
            }
        ]
    },
    \"auth\": ${token_info},
    \"id\": 1
}" -H "Content-Type: application/json-rpc" ${zabbix_url}api_jsonrpc.php | jq .