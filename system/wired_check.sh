#!/bin/bash

PING_ADDR="www.hkust-gz.edu.cn"

EMAIL_RECIPIANT="zirui.wu@hkust-gz.edu.cn"

PATH_DIR="$HOME/.log/wired.log"

online() {
    ## Test if online - prototype code
    ping -c 1  $PING_ADDR 
    return $?
}
until online
do
    echo "waiting for network connection"
    sleep 5
done
echo
echo "start monitoring, logging to ${PATH_DIR} at $(date)" | tee ${PATH_DIR}

while true; do
    echo "Script executed at $(date)" | tee -a ${PATH_DIR}
    # Check connection status
    if ! ping -c 1 $PING_ADDR > /dev/null 2>&1; then
        # No connection
        echo "[ERROR] no connection, and sleep 2s" | tee -a ${PATH_DIR}
        sleep 2 # Wait for 2s
        
        # Check again
        if ! ping -c 1 $PING_ADDR &> /dev/null; then
            # Still no connection, toggle WiFi
            echo "[ERROR] no connection, try to reconnect" | tee -a ${PATH_DIR}
            echo "turn off wired and sleep 5s" >> ${PATH_DIR}
	    nmcli con down id "wiredconn"
            sleep 5 # Wait for 5 seconds
            echo "after sleep" >> ${PATH_DIR}
	    nmcli con up id "wiredconn"
            echo "turn on wired" >> ${PATH_DIR}
	    sleep 30 # Wait for 30 seconds
            if ping -c 1 $PING_ADDR &> /dev/null; then
		    #echo $EMAIL_HEADER | (cat - && ip a) | (cat - && uuencode ${PATH_DIR} network_log.txt) | ssmtp $EMAIL_RECIPIANT 
		    printf "From: wuzirui@tztyun.org\nTo: $EMAIL_RECIPIANT\nSubject: Network reset detected\n\nThis is a message from your Ubuntu PC $HOSTNAME. A network reset has been detected recently at %s %s. Please find the network status below and the full system log in the attachments:\n\n" $(date "+%y/%m/%d %H:%M:%S") | (cat - && ip a) | (cat - && uuencode ${PATH_DIR} network_log.txt) | ssmtp $EMAIL_RECIPIANT
		    rm ${PATH_DIR}
		    echo "start monitoring, logging to ${PATH_DIR} at $(date)" | tee ${PATH_DIR}
	    fi
        fi
    fi
    sleep 30 # Wait for 30 seconds before the next check
    
done

