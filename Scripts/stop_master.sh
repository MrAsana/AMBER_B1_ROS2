#!/bin/bash
#
#Attention: run sudo -sE first, or the Master service won't be terminated.
#
if [[ "$(id -u)" != "0" ]]; then                   
      echo "Error: This script need ROOT privilege, pls run 'sudo -sE' first!"
      exit 1                                       
fi  

PIDS=`ps -ef |grep "ros" | grep -v grep | cut -c 9-16`
    if [ "$PIDS" != "" ]; then
    ps -ef |grep "ros" | grep -v grep | cut -c 9-16 |xargs kill -9
    ps -ef |grep "runserver" | grep -v grep | cut -c 9-16 |xargs kill -9
    sleep 2
    echo "The Master and X-Hub service is terminated!"
    
    else
#    if [ "$PIDS" = "" ]; then
        echo "The Master and x-hub  service is not running."
    fi
