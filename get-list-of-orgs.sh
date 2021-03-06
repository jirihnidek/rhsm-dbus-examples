#!/bin/bash

source ./library.sh

start_register_server

echo "Trying to get list of organizations using dbus-send..."
dbus-send --address=${my_addr} --print-reply --dest='com.redhat.RHSM1.Register' \
       '/com/redhat/RHSM1/Register' \
       com.redhat.RHSM1.Register.GetOrgs string:"admin" \
       string:"admin" \
       dict:string:string:"","" \
       string:""


stop_register_server
