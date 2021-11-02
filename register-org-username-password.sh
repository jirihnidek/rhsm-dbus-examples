#!/bin/bash

source ./library.sh

export username="admin"
export password="admin"
export org_id="admin"

start_register_server

# Try to register using username and password
echo "Registering using org, username and password..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
        '/com/redhat/RHSM1/Register' \
        com.redhat.RHSM1.Register.Register \
        string:"${org_id}" \
        string:"${username}" \
        string:"${password}" \
        dict:string:string:"","" \
        dict:string:string:"","" \
        string:"" | gawk '/string/{ $1 = ""; print $0; }' | sed 's/\"//' | sed 's/\(.*\)\"/\1/' > /root/register_output.json

print_registration_result $?

stop_register_server

unregister