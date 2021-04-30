#!/bin/bash

source ./library.sh

# Note: magoo is not member of any organization
export username="magoo"
export password="password"
export org_id=""

start_register_server

# Try to register using username and password
echo "Registering using username and password (NO org)..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
        '/com/redhat/RHSM1/Register' \
        com.redhat.RHSM1.Register.Register \
        string:"${org_id}" \
        string:"${username}" \
        string:"${password}" \
        dict:string:string:"","" \
        dict:string:string:"","" \
        string:"" > /root/register_output.txt

# Error should be returned in this case

print_registration_result $?

stop_register_server

unregister