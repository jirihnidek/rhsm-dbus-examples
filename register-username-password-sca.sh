#!/bin/bash

source ./library.sh

export username="admin"
export password="admin"
export org_id="snowwhite"

start_register_server

# Try to register using username and password
echo "Registering using username and password (org snowwhite)..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
        '/com/redhat/RHSM1/Register' \
        com.redhat.RHSM1.Register.Register \
        string:"${org_id}" \
        string:"${username}" \
        string:"${password}" \
        dict:string:string:"","" \
        dict:string:string:"","" \
        string:"" > /root/register_output.txt

print_registration_result $?

stop_register_server

