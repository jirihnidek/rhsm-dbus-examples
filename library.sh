#!/bin/bash

function start_register_server {
    # Create new UNIX socket used for registration 
    echo "Starting RegisterServer..."
    dbus-send --system --print-reply --dest='com.redhat.RHSM1' \
            '/com/redhat/RHSM1/RegisterServer' \
            com.redhat.RHSM1.RegisterServer.Start string:"" > /root/register_server_output.txt

    if [[ $? -eq 0 ]]
    then
        export my_addr=`cat /root/register_server_output.txt | gawk '/string/{ print $2 }' | sed 's/\"//g'`
        echo "Using address: $my_addr"
    else
        echo "Unable to start RegisterServer"
    fi
}


function print_registration_result {
    if [[ $1 -eq 0 ]]
    then
            echo "Registration SUCCESS"
            export registered=1
    else
            echo "Registration FAILED"
            export registered=0
    fi
}

function stop_register_server {
    if [[ -n "${my_addr}" ]]
    then
        echo "Stopping RegisterServer..."
        dbus-send --system --print-reply --dest='com.redhat.RHSM1' \
                '/com/redhat/RHSM1/RegisterServer' \
                com.redhat.RHSM1.RegisterServer.Stop string:"" > /dev/null
    fi
}

function unregister {
    if [[ $registered -eq 1 ]]
    then
        echo "Unregistering..."
        dbus-send --system --print-reply --dest='com.redhat.RHSM1' '/com/redhat/RHSM1/Unregister' \
                com.redhat.RHSM1.Unregister.Unregister \
                dict:string:string:"","" \
                string:"" > /dev/null
    fi
}