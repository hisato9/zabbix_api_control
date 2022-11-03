#!/bin/bash

zabbix_url=http://<zabbix-ip>/zabbix/

curl -s -d '{
    "jsonrpc": "2.0",
    "method": "user.login",
    "params": {
        "user": "admin",
        "password": "zabbix",
    },
    "id": 1,
    "auth": null
}' -H "Content-Type: application/json-rpc" ${zabbix_url}api_jsonrpc.php | gawk -F'"' '{print $0}'