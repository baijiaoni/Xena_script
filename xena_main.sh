#!/bin/bash 
source xena_config.sh

# Define chassis, port, password and owner
MACHINE=172.16.255.200
PORT=22611
PASSWORD='"xena"'  
OWNER='"Timing"' 

# Open file handle 3 as TCP connection to chassis:port
exec 3<> /dev/tcp/${MACHINE}/${PORT}
if [ $? -eq 0 ]
then
  echo "Telnet accepting connections"
else
  echo "Telnet connections not possible"
  exit 1
fi

# Send commands with echo command to file handle 3
echo -en "C_LOGON ${PASSWORD}\r\n" >&3
# Read answers from file handle 3, (one line a time)
read  <&3 
# Answers are put in $REPLY variable 
echo $REPLY

# Here are some examples
echo -en "C_OWNER ${OWNER}\r\n"  >&3
read  <&3 
echo $REPLY
echo -en "C_TIMEOUT 20\r\n" >&3
read  <&3 
echo $REPLY

chassis_config_info

port_reserve 4/1
port_reserve 4/4
port_reserve 4/5

traffic_stop 4/4
capture_stop 4/4 
traffic_stop 4/5
capture_stop 4/5

stream_config 4/4 04 
stream_config 4/5 05

counter_clear 4/1
traffic_start 4/4
capture_start 4/4 
traffic_start 4/5
capture_start 4/5

tr_info 4/1


#
#
# Close file handle 3
exec 3>&-
if [ $? -eq 0 ]
then
    echo "Telnet accepting close"
else
    echo "Telnet close not possible"
fi