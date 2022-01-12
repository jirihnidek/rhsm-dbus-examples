#!/bin/bash

source ./library.sh

# NOTE: it will be probably necessary to change following organization_id and
# activation key

export org_id="snowwhite"
export activation_key="snowwhite-awesomeos-x86-key-ff8080817d3285d0017d32862b300647"

start_register_server

# Try to register using activation key and org and enable_content. This options should be
# ignored in this case, because it is not possible to do auto-attach and entitlement
# certificates will be updated anyway
echo "Registering using activation key and org..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
       '/com/redhat/RHSM1/Register' \
       com.redhat.RHSM1.Register.RegisterWithActivationKeys \
       string:"${org_id}" \
       array:string:"${activation_key}" \
       dict:string:string:"enable_content","1" \
       dict:string:string:"","" \
       string:"" | gawk '/string/{ $1 = ""; print $0; }' | sed 's/\"//' | sed 's/\(.*\)\"/\1/' > /root/register_output.json

print_registration_result $?

stop_register_server

# unregister
