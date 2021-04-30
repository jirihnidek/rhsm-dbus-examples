#!/bin/bash

source ./library.sh

# NOTE: it will be probably necessary to change following organization_id and
# activation key

export org_id="admin"
export activation_key="admin-awesomeos-all-x86-cont-key-ff808081790d1ea601790d1f089001a3"

start_register_server

# Try to register using activation key and org
echo "Registering using activation key and org..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
       '/com/redhat/RHSM1/Register' \
       com.redhat.RHSM1.Register.RegisterWithActivationKeys \
       string:"${org_id}" \
       array:string:"${activation_key}" \
       dict:string:string:"","" \
       dict:string:string:"","" \
       string:"" > /root/register_output.txt

print_registration_result $?

stop_register_server

unregister
