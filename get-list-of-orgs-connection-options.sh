#!/bin/bash

source ./library.sh

# Note: magoo is not member of any organization
export host="localhost"
export port="8443"
export handler="/candlepin"

start_register_server

echo "Trying to get list of organizations using dbus-send..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
       '/com/redhat/RHSM1/Register' \
       com.redhat.RHSM1.Register.GetOrgs string:"admin" \
       string:"admin" \
       dict:string:string:"host","${host}","port","${port}","handler","${handler}" \
       string:""


stop_register_server
