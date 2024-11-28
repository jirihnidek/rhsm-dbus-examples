#!/bin/bash

source ./library.sh

start_register_server
export username="admin"
export password="admin"
export org_id="content-sources-test"



echo "Trying to get list of organizations using dbus-send..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
       '/com/redhat/RHSM1/Register' \
       com.redhat.RHSM1.Register.GetEnvironments string:${username} \
       string:${password} \
       string:${org_id} \
       dict:string:string:"","" \
       string:""


stop_register_server
